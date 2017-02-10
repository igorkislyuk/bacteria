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

//    if (self.valueObtainer.presenting) {
    [containerView addSubview:toVC.view];
//    }

    //configure layers

    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = 1 / -500.f;
    containerView.layer.transform = perspective;

    toVC.view.layer.transform = [self transformWithAngle:M_PI_2];

    [UIView animateKeyframesWithDuration:self.valueObtainer.duration
                                   delay:0.f
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:^{

                                  [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:0.5f animations:^{
                                      CATransform3D transform3D = [self transformWithAngle:-M_PI_2];
//                                      transform3D = CATransform3DRotate(transform3D, DEGREES_TO_RADIANS(25), 0, 1, 0);
//                                      transform3D = CATransform3DScale(transform3D, 0.9, 0.9, 1);
                                      fromVC.view.layer.transform = transform3D;
                                  }];

                                  [UIView addKeyframeWithRelativeStartTime:0.5f relativeDuration:0.5f animations:^{
                                      toVC.view.layer.transform = [self transformWithAngle:0.f];
                                  }];


                              } completion:^(BOOL finished) {
                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            }];


}

- (CATransform3D)transformWithAngle:(CGFloat)angle {
//    CATransform3D scale = CATransform3DMakeScale(0.5f, 0.5f, 1.f);
    CATransform3D rotation = CATransform3DMakeRotation(angle, 0, 1, 0);
//    return CATransform3DConcat(scale, rotation);
    return rotation;
}


@end
