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

//    toVC.view.layer.transform = [self transformWithAngle:-60.0f];

    [UIView animateKeyframesWithDuration:self.valueObtainer.duration
                                   delay:0.f
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:^{

                                  [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:0.0f animations:^{
                                      fromVC.view.layer.transform = CATransform3DIdentity;

                                      CATransform3D transform3D = [self transformWithAngle:(CGFloat) M_PI_2];
                                      transform3D = CATransform3DTranslate(transform3D, CGRectGetWidth(toVC.view.bounds), 0, 0);
                                      toVC.view.layer.transform = transform3D;
//                                      fromVC.view.layer.anchorPoint = CGPointMake(1.0f, 0.5f);
                                  }];

                                  [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:0.5f animations:^{
                                      CATransform3D transform3D = [self transformWithAngle:(CGFloat) -M_PI_2];
                                      transform3D = CATransform3DTranslate(transform3D, -CGRectGetWidth(fromVC.view.bounds), 0, 0);
                                      fromVC.view.layer.transform = transform3D;
                                  }];

                                  [UIView addKeyframeWithRelativeStartTime:0.5f relativeDuration:0.5f animations:^{
                                      toVC.view.layer.transform = CATransform3DIdentity;
                                  }];


                              } completion:^(BOOL finished) {

                //reset
                containerView.layer.sublayerTransform = CATransform3DIdentity;
                fromVC.view.layer.transform = CATransform3DIdentity;
                toVC.view.layer.transform = CATransform3DIdentity;

                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            }];


}

/// angle in radians
- (CATransform3D)transformWithAngle:(CGFloat)angle {
    CATransform3D transform3D = CATransform3DIdentity;
//    transform3D = CATransform3DScale(transform3D, 1.0f, 0.8f, f);
    transform3D = CATransform3DRotate(transform3D, angle, 0, 1, 0);
//    transform3D = CATransform3DTranslate(transform3D, 0, 0, -100);
    return transform3D;
//    return rotation;
}


@end
