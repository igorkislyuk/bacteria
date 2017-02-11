//
// Created by Igor on 10/02/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import "BCTFlipTransitioningController.h"

#import "BCTTransitioning.h"

@implementation BCTFlipTransitioningController {

}

- (instancetype)initWithValueObtainer:(id <BCTTransitioning>)valueObtainer {
    self = [super init];
    if (self) {
        _valueObtainer = valueObtainer;
    }

    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return self.valueObtainer.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    //get start values
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    [containerView addSubview:toVC.view];

    //configure layers
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = 1 / -500.f;
    containerView.layer.sublayerTransform = perspective;

    [UIView animateKeyframesWithDuration:self.valueObtainer.duration
                                   delay:0.f
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:^{

                                  //prepare part
                                  [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:0.0f animations:^{
                                      [self prepareViewFRTC:fromVC.view];

                                      [self prepareViewFCTL:toVC.view];
                                  }];

                                  [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:0.5f animations:^{
                                      [self collapseViewFRTC:fromVC.view];
                                  }];

                                  [UIView addKeyframeWithRelativeStartTime:0.5f relativeDuration:0.5f animations:^{
                                      [self collapseViewFCTL:toVC.view];
                                  }];


                              } completion:^(BOOL finished) {

                //reset
                containerView.layer.sublayerTransform = CATransform3DIdentity;

                [self resetTransformAndAnchorFor:fromVC.view];
                [self resetTransformAndAnchorFor:toVC.view];

                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            }];


}

- (void)resetTransformAndAnchorFor:(UIView *)view {
    view.layer.transform = CATransform3DIdentity;
    view.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
}

// from center to left
- (void)prepareViewFCTL:(UIView *)view {
    view.layer.transform = CATransform3DMakeRotation((CGFloat) M_PI_2, 0, 1, 0);
    view.layer.anchorPoint = CGPointMake(0.0f, 0.5f);
}

- (void)collapseViewFCTL:(UIView *)view {
    view.layer.transform = CATransform3DMakeTranslation(-CGRectGetWidth(view.bounds) / 2, 0, 0);
}

// from right to center
- (void)prepareViewFRTC:(UIView *)view {
    view.layer.transform = CATransform3DMakeTranslation(CGRectGetWidth(view.bounds) / 2, 0, 0);
    view.layer.anchorPoint = CGPointMake(1.0f, 0.5f);
}

- (void)collapseViewFRTC:(UIView *)view {
    CATransform3D transform3D = view.layer.transform;
    transform3D = CATransform3DTranslate(transform3D, -CGRectGetWidth(view.bounds) / 2.0f, 0, 0);
    transform3D = CATransform3DRotate(transform3D, (CGFloat) -M_PI_2, 0, 1, 0);
    view.layer.transform = transform3D;
}

@end
