//
// Created by Igor on 07/02/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#define DEGREES_TO_RADIANS(degrees) (CGFloat)((M_PI * degrees)/180.f)


#import "BCTSafariTransitioningController.h"

#import "BCTTransitioning.h"

//constants
static NSString *const kMovelUpAnimation = @"moveUpOldLayerAnimation";

@interface BCTSafariTransitioningController () <CAAnimationDelegate>

@property(nonatomic, assign) BOOL presenting;

@property(nonatomic, strong) id <UIViewControllerContextTransitioning> transitionContext;

//@property(nonatomic, strong) NSMutableSet *viewsToRemove;
//@property(nonatomic, strong) NSMutableArray *viewsToAdd;

@end

@implementation BCTSafariTransitioningController {
    CABasicAnimation *_appearAnimation, *_dismissAnimation;
    UIView *_presentView, *_presentSnaphotView, *_dismissSnapshotView;
}

- (instancetype)initWithValueObtainer:(id <BCTTransitioning>)valueObtainer {
    self = [super init];
    if (self) {
        _valueObtainer = valueObtainer;
//        _viewsToAdd = [[NSMutableArray alloc] init];
//        _viewsToRemove = [[NSMutableSet alloc] init];
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
    return nil; //todo: self
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

    [self setPerspectiveIn:containerView enabled:YES];

    //create snaps
    UIView *oldSnapshotView = [fromVC.view snapshotViewAfterScreenUpdates:YES];
    [containerView addSubview:oldSnapshotView];
    _dismissSnapshotView = oldSnapshotView;

    [fromVC.view removeFromSuperview];

    _presentView = toVC.view;

    UIView *newSnapshotView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    [containerView insertSubview:newSnapshotView aboveSubview:oldSnapshotView];
    _presentSnaphotView = newSnapshotView;

    [containerView addSubview:_presentView];
    _presentView.alpha = 0.f;


    //---

    //interval
    NSTimeInterval duration = self.valueObtainer.duration / 2;
    NSTimeInterval durationWithDelay = CACurrentMediaTime() + duration;
    //container height
    CGFloat height = CGRectGetHeight(containerView.bounds);

    //animation move to back
    CABasicAnimation *moveBackAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];

    _dismissSnapshotView.layer.transform = [self transformForPage];
    
    moveBackAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    moveBackAnimation.toValue = [NSValue valueWithCATransform3D:[self transformForPage]];
    moveBackAnimation.duration = duration;
    moveBackAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_dismissSnapshotView.layer addAnimation:moveBackAnimation forKey:nil];

    //animation appears from bottom
    CATransform3D startTransform = CATransform3DConcat([self transformForPage], CATransform3DMakeTranslation(0, height, 0));
    _presentSnaphotView.layer.transform = startTransform;
    CABasicAnimation *animationFromBottom = [CABasicAnimation animationWithKeyPath:@"transform"];
    animationFromBottom.fromValue = [NSValue valueWithCATransform3D:startTransform];
    animationFromBottom.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animationFromBottom.duration = duration;
    animationFromBottom.beginTime = durationWithDelay;
    animationFromBottom.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationFromBottom.removedOnCompletion = NO;

    //main animation to track progress
    animationFromBottom.delegate = self;

    [_presentSnaphotView.layer addAnimation:animationFromBottom forKey:nil];

    //animation for move layer up
    CATransform3D upTransform = CATransform3DTranslate([self transformForPage], 0, -height * 2, 0);
    _dismissSnapshotView.layer.transform = upTransform;

    CABasicAnimation *moveOldUpAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];

    moveOldUpAnimation.fromValue = [NSValue valueWithCATransform3D:[self transformForPage]];
    moveOldUpAnimation.toValue = [NSValue valueWithCATransform3D:upTransform];

    moveOldUpAnimation.duration = duration;
    moveOldUpAnimation.beginTime = durationWithDelay;
    moveOldUpAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    moveOldUpAnimation.removedOnCompletion = NO;
    moveOldUpAnimation.delegate = self;
    [_dismissSnapshotView.layer addAnimation:moveOldUpAnimation forKey:kMovelUpAnimation];

    self.transitionContext = transitionContext;
}

- (CATransform3D)transformForPage {

    CATransform3D scale = CATransform3DMakeScale(0.8, 0.75, 0.9);
    CATransform3D rotate = CATransform3DMakeRotation(DEGREES_TO_RADIANS(-25), 1, 0, 0);
    return CATransform3DConcat(scale, rotate);
}

- (void)cleanUpAfterFinish {

    UIView *containerView = [self.transitionContext containerView];

    //remove perspective
    [self setPerspectiveIn:containerView enabled:NO];

    //add toVC view
//    [containerView addSubview:_presentView];
    _presentView.alpha = 1.f;
    [_presentSnaphotView removeFromSuperview];

    containerView.layer.zPosition = 1.f;
//    for (UIView *add in self.viewsToAdd) {
//        [containerView addSubview:add];
//    }

    [self.transitionContext completeTransition:YES];

//    for (UIView *view in self.viewsToRemove) {
//        [view removeFromSuperview];
//    }

}

- (void)setPerspectiveIn:(UIView *)view enabled:(BOOL)enabled {
    if (enabled) {
        CATransform3D perspective = CATransform3DIdentity;
        perspective.m34 = 1.f / -1800.f;
        view.layer.sublayerTransform = perspective;
    } else {
        view.layer.sublayerTransform = CATransform3DIdentity;
    }
}

#pragma mark - Animation Delegate

- (void)animationDidStart:(CAAnimation *)anim {

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"%s", sel_getName(_cmd));

    if ([anim isEqual:[_dismissSnapshotView.layer animationForKey:kMovelUpAnimation]]) {
        //remove this
        [_dismissSnapshotView removeFromSuperview];
    } else {

        [self cleanUpAfterFinish];
    }


}


@end
