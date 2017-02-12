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

    CGRect startPopRect = self.valueObtainer.startPopRect;

    //path
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:startPopRect];

    CGPoint extremePoint = [self extremePointWithRect:startPopRect inView:_presentView];
    CGFloat radius = (CGFloat) sqrt((extremePoint.x * extremePoint.x) + (extremePoint.y * extremePoint.y));
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(startPopRect, -radius, -radius)];

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

- (CGPoint)extremePointWithRect:(CGRect)rect inView:(UIView *)view {
    CGPoint result;

    CGFloat x = ( CGRectGetMidX(rect) <= CGRectGetMidX(view.bounds) ) ?
            CGRectGetWidth(view.bounds) - CGRectGetMidX(rect) :
            CGRectGetMidX(rect);
    CGFloat y = (CGRectGetMidY(rect) <= CGRectGetMidY(view.bounds)) ?
            CGRectGetHeight(view.bounds) - CGRectGetMidY(rect) :
            CGRectGetMidY(rect);
    result.x = x;
    result.y = y;

    return result;
}

@end
