//
// Created by Igor on 07/02/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#define DEGREES_TO_RADIANS(degrees) ((M_PI * degrees)/180.f)

#import "BCTSafariTransitioningController.h"

#import "BCTTransitioning.h"

@interface BCTSafariTransitioningController() <CAAnimationDelegate>

@property(nonatomic, assign) BOOL presenting;

@property (nonatomic, strong) id <UIViewControllerContextTransitioning> transitionContext;

@end

@implementation BCTSafariTransitioningController {
    
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
    
    //get snapshot

    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = 1.f / -1800.f;
    containerView.layer.sublayerTransform = perspective;

    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];

    CATransform3D transform3D = fromVC.view.layer.transform;
    transform3D = CATransform3DScale(transform3D, 0.75, 0.75, 1);
    transform3D = CATransform3DRotate(transform3D, DEGREES_TO_RADIANS(-25), 1, 0, 0);

    scale.fromValue = [NSValue valueWithCATransform3D:fromVC.view.layer.transform];
    scale.toValue = [NSValue valueWithCATransform3D:transform3D];

    scale.duration = self.valueObtainer.duration / 2;

    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    [fromVC.view.layer addAnimation:scale forKey:nil];



//    [fromVClayer addAnimation:animation forKey:nil];

    //create animation
//    animation.delegate = self;

    self.transitionContext = transitionContext;
}

#pragma mark - Animation Delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

//    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];

}


@end