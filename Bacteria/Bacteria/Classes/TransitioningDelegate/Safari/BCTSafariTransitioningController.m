//
// Created by Igor on 07/02/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#define DEGREES_TO_RADIANS(degrees) (CGFloat)((M_PI * degrees)/180.f)

#import "BCTSafariTransitioningController.h"

#import "BCTTransitioning.h"

@interface BCTSafariTransitioningController() <CAAnimationDelegate>

@property(nonatomic, assign) BOOL presenting;

@property (nonatomic, strong) id <UIViewControllerContextTransitioning> transitionContext;

@property (nonatomic, strong) NSMutableSet *views;

@end

@implementation BCTSafariTransitioningController {
    
}

- (instancetype)initWithValueObtainer:(id <BCTTransitioning>)valueObtainer {
    self = [super init];
    if (self) {
        _valueObtainer = valueObtainer;
        _views = [[NSMutableSet alloc] init];
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
    if (self.presenting) {

        [containerView addSubview:toVC.view];

    } else {

        [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    }

    //perspective
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = 1.f / -1800.f;
    containerView.layer.sublayerTransform = perspective;

    //create animation view
    UIView *snapshotView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    [containerView addSubview:snapshotView];

//    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
//
//    CATransform3D transform3D = snapshotView.layer.transform;
//    transform3D = CATransform3DScale(transform3D, 0.75, 0.75, 1);
//    transform3D = CATransform3DRotate(transform3D, DEGREES_TO_RADIANS(-25), 1, 0, 0);
//
//    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:snapshotView.layer.transform];
//    scaleAnimation.toValue = [NSValue valueWithCATransform3D:transform3D];
//
//    scaleAnimation.duration = self.valueObtainer.duration / 2;
//
//    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//
//    [snapshotView.layer addAnimation:scaleAnimation forKey:nil];
    //    scaleAnimation.delegate = self;
    
    [UIView animateWithDuration:self.valueObtainer.duration animations:^{
        snapshotView.transform = CGAffineTransformMakeTranslation(0, -200);
    } completion:^(BOOL finished) {
        
        [snapshotView removeFromSuperview];
        
        [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
        
    }];
    
//    [self.views addObject:snapshotView];

    //create animation

    self.transitionContext = transitionContext;
}

#pragma mark - Animation Delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

    

    for (UIView *view in self.views) {
        [view removeFromSuperview];
    }

}


@end
