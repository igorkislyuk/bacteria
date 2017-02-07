//
//  BCTTransitioningDelegate.m
//  Bacteria
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import "BCTTransitioningController.h"

#import "BCTViewPerformer.h"
#import "BCTBasicViewPerformer.h"

#import "BCTCoverViewDismissal.h"
#import "BCTCoverViewPresenter.h"

#import "BCTParallelViewPresenter.h"
#import "BCTParallelViewDismissal.h"


@interface BCTTransitioningController ()

@property(nonatomic) BCTBasicViewPerformer<BCTViewPerformer> *performer;

@property(nonatomic, assign) BOOL presenting;

@property(nonatomic, strong) UIView *dismissView;
@property(nonatomic, strong) UIView *presentView;

@end

@implementation BCTTransitioningController {

}

- (instancetype)initWithValueObtainer:(id <BCTTransitioning>)valueObtainer {
    self = [super init];
    if (self) {
        _valueObtainer = valueObtainer;
    }

    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.presenting = YES;
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.presenting = NO;
    return self;
}

#pragma mark - Animated transitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return self.valueObtainer.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    //get start values
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    //store views
    self.dismissView = fromVC.view;
    self.presentView = toVC.view;

    //create local point locations - both are CGPointZero
    CGPoint _startLocationPoint = CGPointZero, _endLocationPoint = CGPointZero;

    //necessary logic for adding / moving & location
    if (self.presenting) {

        [containerView addSubview:self.presentView];

        _startLocationPoint = self.valueObtainer.presentStartPoint;

        self.performer = [self viewPresenterWithType:self.valueObtainer.presentType];

    } else {

        //create performer
        self.performer = [self viewDismissalWithType:self.valueObtainer.dismissType];

        [containerView insertSubview:self.presentView belowSubview:self.dismissView];

        _endLocationPoint = self.valueObtainer.dismissEndPoint;
    }

    //count differences
    CGFloat dx = _startLocationPoint.x - _endLocationPoint.x;
    CGFloat dy = _startLocationPoint.y - _endLocationPoint.y;
    CGPoint point = CGPointMake(dx, dy);

    //common part
    self.performer.offsetPoint = point;
    self.performer.startScale = self.valueObtainer.startScale;
    self.performer.endScale = self.valueObtainer.endScale;

    //request initial state of new view
    self.presentView = [self.performer presentedViewBefore];

    [UIView animateWithDuration:self.valueObtainer.duration animations:^{

        //request final state of new view
        self.presentView = [self.performer presentedViewAfter];

        //request final state of old view
        self.dismissView = [self.performer dismissedViewAfter];

    }                completion:^(BOOL finished) {

        //request initial state of old view
        self.dismissView = [self.performer dismissedViewBefore];

        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];

    }];
}

#pragma mark - Helpers

- (id <BCTViewPerformer>)viewPresenterWithType:(BCTTransitionType)transitionType {

    id <BCTViewPerformer> result;
    switch (transitionType) {

        case BCTTransitionTypeParallel:
            result = [[BCTParallelViewPresenter alloc] initWithPresentedView:self.presentView dismissedView:self.dismissView];
            break;
        case BCTTransitionTypeCover:
            result = [[BCTCoverViewPresenter alloc] initWithPresentedView:self.presentView dismissedView:self.dismissView];
            break;
    }

    return result;
}

- (id <BCTViewPerformer>)viewDismissalWithType:(BCTTransitionType)transitionType {

    id <BCTViewPerformer> result;
    switch (transitionType) {

        case BCTTransitionTypeParallel:
            result = [[BCTParallelViewDismissal alloc] initWithPresentedView:self.presentView dismissedView:self.dismissView];
            break;
        case BCTTransitionTypeCover:
            result = [[BCTCoverViewDismissal alloc] initWithPresentedView:self.presentView dismissedView:self.dismissView];
            break;
    }

    return result;
}

@end
