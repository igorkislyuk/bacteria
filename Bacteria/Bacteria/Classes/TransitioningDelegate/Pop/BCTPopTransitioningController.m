//
// Created by Igor on 12/02/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import "BCTPopTransitioningController.h"

@interface BCTPopTransitioningController() <CAAnimationDelegate>

@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;

@end

@implementation BCTPopTransitioningController {
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

    self.transitionContext = transitionContext;

    //get start values
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    [containerView addSubview:toVC.view];

    _dismissView = fromVC.view;
    _presentView = toVC.view;

    UIView *startPopView = self.valueObtainer.startPopView;

    CGRect rect = startPopView.frame;

    if (CGPointEqualToPoint(startPopView.frame.origin, CGPointZero)) {
        CGPoint test = [startPopView convertPoint:startPopView.frame.origin toView:_presentView];
        rect.origin = test;
    }

    //path
    NSLog(@"NSStringFromCGRect(rect) = %@", NSStringFromCGRect(rect));
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:rect];

    CGPoint extremePoint = [self extremePointWithView:startPopView inView:_presentView];
    CGFloat radius = (CGFloat) sqrt((extremePoint.x * extremePoint.x) + (extremePoint.y * extremePoint.y));
    CGRect newRect = CGRectInset(rect, -radius, -radius);
    NSLog(@"NSStringFromCGRect(newRect) = %@", NSStringFromCGRect(newRect));
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:newRect];

    //create mask for present view
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = endPath.CGPath;
    _presentView.layer.mask = shapeLayer;

    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnimation.fromValue = (id)startPath.CGPath;
    basicAnimation.toValue = (id)endPath.CGPath;
    basicAnimation.duration = self.valueObtainer.duration;
    basicAnimation.delegate = self;

    [shapeLayer addAnimation:basicAnimation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.transitionContext) {
        [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];

        _presentView.layer.mask = nil;
    }
}

- (CGPoint)extremePointWithView:(UIView *)view inView:(UIView *)mainView {
    CGPoint result;

    CGFloat x = ( CGRectGetMidX(view.frame) <= CGRectGetMidX(mainView.frame) ) ?
            CGRectGetWidth(mainView.frame) - CGRectGetMidX(view.frame) :
            CGRectGetMidX(view.frame);
    CGFloat y = (CGRectGetMidY(view.frame) <= CGRectGetMidY(mainView.frame)) ?
            CGRectGetHeight(mainView.frame) - CGRectGetMidY(view.frame) :
            CGRectGetMidY(view.frame);
    result.x = x;
    result.y = y;

    return result;
}

@end
