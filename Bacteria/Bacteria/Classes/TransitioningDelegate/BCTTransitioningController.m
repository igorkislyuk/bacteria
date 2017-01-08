//
//  BCTTransitioningDelegate.m
//  Bacteria
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import "BCTTransitioningController.h"
#import "BCTParallelLocationPerformer.h"


@interface BCTTransitioningController ()

@property(nonatomic) id <BCTViewPerformer> performer;

@property (nonatomic, assign) BOOL presenting;

@property (nonatomic, strong) UIView *dismissView;
@property (nonatomic, strong) UIView *presentView;

@end

@implementation BCTTransitioningController {

}

- (instancetype)init {

    self = [super init];
    if (self) {

        _startScale = CGSizeMake(1, 1);
        _endScale = CGSizeMake(1, 1);

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
    return self.duration;
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
    CGPoint _startLocationPoint, _endLocationPoint;

    //necessary logic for adding / moving & location
    if (self.presenting) {
        [containerView addSubview:self.presentView];

        _startLocationPoint = self.presentStartPoint;

    } else {
        [containerView insertSubview:self.presentView belowSubview:self.dismissView];

        _endLocationPoint = self.dismissEndPoint;
    }

    //count differences
    CGFloat dx = _startLocationPoint.x - _endLocationPoint.x;
    CGFloat dy = _startLocationPoint.y - _endLocationPoint.y;
    CGPoint point = CGPointMake(dx, dy);

    //create performer
    self.performer = [self locationPerformerOfType:[self transitionTypeWithPresenting] withPoint:point];

    //request initial state of new view
    self.presentView = [self.performer presentedViewBefore];

    [UIView animateWithDuration:self.duration animations:^{

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

- (BCTTransitionType)transitionTypeWithPresenting {
    return self.presenting ? self.presentType : self.dismissType;
}

- (id <BCTViewPerformer>)locationPerformerOfType:(BCTTransitionType)transitionType withPoint:(CGPoint)point {

    // todo: condition here

    id <BCTViewPerformer> result = [[BCTParallelLocationPerformer alloc]
            initWithPresentedView:self.presentView
                    dismissedView:self.dismissView];

    //common part
    result.offsetPoint = point;
    result.startScale = self.startScale;
    result.endScale = self.endScale;

    return result;
}

@end
