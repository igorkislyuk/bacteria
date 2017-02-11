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

                                  CGFloat toWidth = CGRectGetWidth(toVC.view.bounds);
                                  CGFloat fromWidth = CGRectGetWidth(fromVC.view.bounds);

                                  //prepare part
                                  [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:0.0f animations:^{
                                      fromVC.view.layer.transform = CATransform3DMakeTranslation(fromWidth / 2, 0, 0);
                                      fromVC.view.layer.anchorPoint = CGPointMake(1.0f, 0.5f);

                                      CATransform3D transform3D = CATransform3DIdentity;
                                      transform3D = CATransform3DRotate(transform3D, (CGFloat) M_PI_2, 0, 1, 0);

                                      toVC.view.layer.transform = transform3D;
                                      toVC.view.layer.anchorPoint = CGPointMake(0.0f, 0.5f);
                                  }];

                                  [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:0.5f animations:^{
                                      CATransform3D transform3D = fromVC.view.layer.transform;
                                      transform3D = CATransform3DTranslate(transform3D, - fromWidth / 2.0f, 0, 0);
                                      transform3D = CATransform3DRotate(transform3D, (CGFloat) -M_PI_2, 0, 1, 0);
                                      fromVC.view.layer.transform = transform3D;
                                  }];

                                  [UIView addKeyframeWithRelativeStartTime:0.5f relativeDuration:0.5f animations:^{
                                      toVC.view.layer.transform = CATransform3DMakeTranslation(-toWidth / 2, 0, 0);
                                  }];


                              } completion:^(BOOL finished) {

                //reset
                containerView.layer.sublayerTransform = CATransform3DIdentity;

                fromVC.view.layer.transform = CATransform3DIdentity;
                toVC.view.layer.transform = CATransform3DIdentity;

                fromVC.view.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
                toVC.view.layer.anchorPoint = CGPointMake(0.5f, 0.5f);

                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            }];


}

@end
