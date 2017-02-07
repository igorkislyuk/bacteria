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

    //store views

    CATransform3D fromTransform = fromVC.view.layer.transform;

    fromTransform = CATransform3DRotate(fromTransform, DEGREES_TO_RADIANS(-17), 1, 0, 0);

    fromTransform = CATransform3DTranslate(fromTransform, 0, -100, 0);

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];

    animation.duration = self.valueObtainer.duration;
    animation.fromValue = [NSValue valueWithCATransform3D:fromVC.view.layer.transform];
    animation.toValue = [NSValue valueWithCATransform3D:fromTransform];

    fromVC.view.layer.transform = fromTransform;
    [fromVC.view.layer addAnimation:animation forKey:nil];
    
    //create animation
    animation.delegate = self;

    self.transitionContext = transitionContext;
}

#pragma mark - Animation Delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];

}


@end