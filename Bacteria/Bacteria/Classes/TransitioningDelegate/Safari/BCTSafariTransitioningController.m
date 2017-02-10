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
@end

@implementation BCTSafariTransitioningController {
    CABasicAnimation *_appearAnimation, *_dismissAnimation;
    UIView *_presentView, *_presentSnaphotView, *_dismissSnapshotView;
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

//    [containerView addSubview:_presentView];
//    _presentView.alpha = 0.f;


    //---

    //interval
    NSTimeInterval duration = self.valueObtainer.duration;
//    NSTimeInterval durationWithDelay = CACurrentMediaTime() + duration;
    //container height
    CGFloat height = CGRectGetHeight(containerView.bounds);

    //animation move to back & up
    CATransform3D upTransform = CATransform3DTranslate([self transformForPage], 0, -height * 1.25f, 0);
    _dismissSnapshotView.layer.transform = upTransform;

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform";
    animation.duration = duration;
    animation.values = @[
            [NSValue valueWithCATransform3D:CATransform3DIdentity],
            [NSValue valueWithCATransform3D:[self transformForPage]],
            [NSValue valueWithCATransform3D:upTransform],
    ];
    animation.keyTimes = @[@(0.f), @(0.5), @(1.f)];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    [_dismissSnapshotView.layer addAnimation:animation forKey:nil];


    //animation appears from bottom
    CATransform3D startTransform = CATransform3DConcat([self transformForPage], CATransform3DMakeTranslation(0, height, 0));
//    _presentSnaphotView.layer.transform = startTransform;

//    CABasicAnimation *animationFromBottom = [CABasicAnimation animationWithKeyPath:@"transform"];
//    animationFromBottom.fromValue = [NSValue valueWithCATransform3D:startTransform];
//    animationFromBottom.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    animationFromBottom.duration = duration;
//    animationFromBottom.beginTime = durationWithDelay;
//    animationFromBottom.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animationFromBottom.removedOnCompletion = NO;

    //main animation to track progress
//    animationFromBottom.delegate = self;

    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    keyframeAnimation.keyTimes =  @[@(0.5), @(1.f)];
    keyframeAnimation.values = @[
            [NSValue valueWithCATransform3D:startTransform],
            [NSValue valueWithCATransform3D:CATransform3DIdentity],
    ];
    keyframeAnimation.duration = duration;
    keyframeAnimation.delegate = self;
    keyframeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    [_presentSnaphotView.layer addAnimation:keyframeAnimation forKey:nil];

    self.transitionContext = transitionContext;
}

- (CATransform3D)transformForPage {

    CATransform3D scale = CATransform3DMakeScale(0.8, 0.75, 0.9);
    CATransform3D rotate = CATransform3DMakeRotation(DEGREES_TO_RADIANS(-25), 1, 0, 0);
    return CATransform3DConcat(scale, rotate);
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

    _presentSnaphotView.layer.transform = CATransform3DIdentity;

    UIView *containerView = [self.transitionContext containerView];

    [containerView insertSubview:_presentView belowSubview:_presentSnaphotView];
    [_presentSnaphotView removeFromSuperview];

//    [_dismissSnapshotView removeFromSuperview];
    [self.transitionContext completeTransition:YES];

}


@end
