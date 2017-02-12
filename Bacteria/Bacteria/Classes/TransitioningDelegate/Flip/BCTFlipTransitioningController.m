//
// Created by Igor on 10/02/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import "BCTFlipTransitioningController.h"

#import "BCTTransitioning.h"

NSString *const kBCTTransitionDirectionFlipFailMessage = @"BCTDirectionType with unsupported side. Please contact maintainer";

@implementation BCTFlipTransitioningController {
    UIView *_presentView, *_dismissView;
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

    _dismissView = fromVC.view;
    _presentView = toVC.view;

    //configure container
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = 1 / -500.f;
    containerView.layer.sublayerTransform = perspective;

    //get value for flip
    BCTDirectionType directionType = [self directionType];

    [UIView animateKeyframesWithDuration:self.valueObtainer.duration
                                   delay:0.f
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:^{

                                  //prepare part
                                  [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:0.0f animations:^{
                                      [self prepareForFlipFromDirection:directionType];
                                  }];

                                  [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:0.5f animations:^{
                                      [self animateFirstPartFromDirection:directionType];
                                  }];

                                  [UIView addKeyframeWithRelativeStartTime:0.5f relativeDuration:0.5f animations:^{
                                      [self animateSecondPartFromDirection:directionType];
                                  }];


                              } completion:^(BOOL finished) {

                //finish part
                containerView.layer.sublayerTransform = CATransform3DIdentity;

                [self resetTransformAndAnchorFor:_dismissView];
                [self resetTransformAndAnchorFor:_presentView];

                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            }];


}

#pragma mark - Animations

- (void)prepareForFlipFromDirection:(BCTDirectionType)type {

    if (type == BCTDirectionRight) {

        [self prepareViewFRTC:_dismissView];
        [self prepareViewFCTL:_presentView];
    } else if (type == BCTDirectionLeft) {

        [self prepareViewFLTC:_dismissView];
        [self prepareViewFCTR:_presentView];
    } else if (type == BCTDirectionTop) {

        [self prepareViewFTTC:_dismissView];
        [self prepareViewFCTB:_presentView];

    } else if (type == BCTDirectionBottom) {

        [self prepareViewFBTC:_dismissView];
        [self prepareViewFCTT:_presentView];
    } else {
        NSLog(kBCTTransitionDirectionFlipFailMessage);
    }
}

- (void)animateFirstPartFromDirection:(BCTDirectionType)type {
    if (type == BCTDirectionRight) {

        [self animateViewFRTC:_dismissView];
    } else if (type == BCTDirectionLeft) {

        [self animateViewFLTC:_dismissView];
    } else if (type == BCTDirectionTop) {

        [self animateViewFTTC:_dismissView];

    } else if (type == BCTDirectionBottom) {

        [self animateViewFBTC:_dismissView];
    } else {
        NSLog(kBCTTransitionDirectionFlipFailMessage);
    }
}

- (void)animateSecondPartFromDirection:(BCTDirectionType)sideType {
    if (sideType == BCTDirectionRight) {

        [self animateViewFCTL:_presentView];
    } else if (sideType == BCTDirectionLeft) {

        [self animateViewFCTR:_presentView];
    } else if (sideType == BCTDirectionTop) {

        [self animateViewFCTB:_presentView];

    } else if (sideType == BCTDirectionBottom) {

        [self animateViewFCTT:_presentView];
    } else {
        NSLog(kBCTTransitionDirectionFlipFailMessage);
    }
}

#pragma mark - Helpers

- (CGFloat)halfWidth:(UIView *)view {
    return CGRectGetWidth(view.bounds) / 2.0f;
}

- (CGFloat)halfHeight:(UIView *)view {
    return CGRectGetHeight(view.bounds) / 2.0f;
}

- (BCTDirectionType)directionType {
    BCTDirectionType sideType;

    if (self.valueObtainer.presenting) {
        sideType = self.valueObtainer.presentDirectionType;
    } else {
        sideType = self.valueObtainer.dismissDirectionType;
    }

    switch (sideType) {
        case BCTDirectionTopLeft:
            sideType = BCTDirectionTop;
            break;
        case BCTDirectionBottomLeft:
            sideType = BCTDirectionLeft;
            break;
        case BCTDirectionBottomRight:
            sideType = BCTDirectionBottom;
            break;
        case BCTDirectionTopRight:
            sideType = BCTDirectionRight;
            break;
        default:
            break;
    }

    return sideType;
}

- (void)resetTransformAndAnchorFor:(UIView *)view {
    view.layer.transform = CATransform3DIdentity;
    view.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
}

#pragma mark - Top animation

//from top to center
- (void)prepareViewFTTC:(UIView *)view {
    view.layer.transform = CATransform3DMakeTranslation(0, -[self halfHeight:view], 0);
    view.layer.anchorPoint = CGPointMake(0.5f, 0.0f);
}

- (void)animateViewFTTC:(UIView *)view {
    CATransform3D transform3D = view.layer.transform;
    transform3D = CATransform3DTranslate(transform3D, 0, [self halfHeight:view], 0);
    transform3D = CATransform3DRotate(transform3D, (CGFloat) -M_PI_2, 1, 0, 0);
    view.layer.transform = transform3D;
}

//from center to bottom
- (void)prepareViewFCTB:(UIView *)view {
    view.layer.anchorPoint = CGPointMake(0.5f, 1.0f);
    view.layer.transform = CATransform3DMakeRotation((CGFloat) M_PI_2, 1, 0, 0);
}

- (void)animateViewFCTB:(UIView *)view {
    view.layer.transform = CATransform3DMakeTranslation(0, [self halfHeight:view], 0);
}

#pragma mark - Bottom animation

//from bottom to center
- (void)prepareViewFBTC:(UIView *)view {
    view.layer.transform = CATransform3DMakeTranslation(0, [self halfHeight:view], 0);
    view.layer.anchorPoint = CGPointMake(0.5f, 1.0f);
}

- (void)animateViewFBTC:(UIView *)view {
    CATransform3D transform3D = view.layer.transform;
    transform3D = CATransform3DTranslate(transform3D, 0, -[self halfHeight:view], 0);
    transform3D = CATransform3DRotate(transform3D, (CGFloat) M_PI_2, 1, 0, 0);
    view.layer.transform = transform3D;
}

//from center to top
- (void)prepareViewFCTT:(UIView *)view {
    view.layer.anchorPoint = CGPointMake(0.5f, 0.0f);
    view.layer.transform = CATransform3DMakeRotation((CGFloat) -M_PI_2, 1, 0, 0);
}

- (void)animateViewFCTT:(UIView *)view {
    view.layer.transform = CATransform3DMakeTranslation(0, -[self halfHeight:view], 0);
}

#pragma mark - Left animation

//from left to center
- (void)prepareViewFLTC:(UIView *)view {
    view.layer.transform = CATransform3DMakeTranslation(-[self halfWidth:view], 0, 0);
    view.layer.anchorPoint = CGPointMake(0.0f, 0.5f);
}

- (void)animateViewFLTC:(UIView *)view {
    CATransform3D transform3D = view.layer.transform;
    transform3D = CATransform3DTranslate(transform3D, [self halfWidth:view], 0, 0);
    transform3D = CATransform3DRotate(transform3D, (CGFloat) M_PI_2, 0, 1, 0);
    view.layer.transform = transform3D;
}

//from center to right
- (void)prepareViewFCTR:(UIView *)view {
    view.layer.transform = CATransform3DMakeRotation((CGFloat) -M_PI_2, 0, 1, 0);
    view.layer.anchorPoint = CGPointMake(1.0f, 0.5f);
}

- (void)animateViewFCTR:(UIView *)view {
    view.layer.transform = CATransform3DMakeTranslation([self halfWidth:view], 0, 0);
}

#pragma mark - Right animation

//from right to center
- (void)prepareViewFRTC:(UIView *)view {
    view.layer.transform = CATransform3DMakeTranslation([self halfWidth:view], 0, 0);
    view.layer.anchorPoint = CGPointMake(1.0f, 0.5f);
}

- (void)animateViewFRTC:(UIView *)view {
    CATransform3D transform3D = view.layer.transform;
    transform3D = CATransform3DTranslate(transform3D, -[self halfWidth:view], 0, 0);
    transform3D = CATransform3DRotate(transform3D, (CGFloat) -M_PI_2, 0, 1, 0);
    view.layer.transform = transform3D;
}

//from center to left
- (void)prepareViewFCTL:(UIView *)view {
    view.layer.transform = CATransform3DMakeRotation((CGFloat) M_PI_2, 0, 1, 0);
    view.layer.anchorPoint = CGPointMake(0.0f, 0.5f);
}

- (void)animateViewFCTL:(UIView *)view {
    view.layer.transform = CATransform3DMakeTranslation(-[self halfWidth:view], 0, 0);
}

@end
