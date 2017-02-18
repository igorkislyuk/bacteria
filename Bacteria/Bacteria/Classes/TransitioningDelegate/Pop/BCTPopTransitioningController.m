//
// Created by Igor on 12/02/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import "BCTPopTransitioningController.h"

const float kBCTDefaultRectSize = 100.0f;

@interface BCTPopTransitioningController () <CAAnimationDelegate>

@property(nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;

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

    //get start values & save it
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    _dismissView = fromVC.view;
    _presentView = toVC.view;

    [containerView addSubview:_presentView];

    if (self.valueObtainer.presenting) {
        [self animatePresent];
    } else {
        [self animateDismiss];

        [containerView bringSubviewToFront:_dismissView];
    }

}

- (void)animatePresent {

    CGRect smallRect, bigRect;

    smallRect = [self rectForInitialState];
    NSLog(@"NSStringFromCGRect(smallRect) = %@", NSStringFromCGRect(smallRect));

    CGFloat radius = [self distanceToMostFarCornerWithPoint:[self centerPointIn:smallRect] inView:_dismissView];
    bigRect = CGRectInset(smallRect, -radius, -radius);
    NSLog(@"NSStringFromCGRect(bigRect) = %@", NSStringFromCGRect(bigRect));

    UIBezierPath *smallPath = [UIBezierPath bezierPathWithOvalInRect:smallRect];
    UIBezierPath *bigPath = [UIBezierPath bezierPathWithOvalInRect:bigRect];

    //create mask for present view
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bigPath.CGPath;
    _presentView.layer.mask = shapeLayer;

    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnimation.fromValue = (id) smallPath.CGPath;
    basicAnimation.toValue = (id) bigPath.CGPath;
    basicAnimation.duration = self.valueObtainer.duration;
    basicAnimation.delegate = self;

    [shapeLayer addAnimation:basicAnimation forKey:nil];
}

- (void)animateDismiss {

    CGRect smallRect, bigRect;

    smallRect = [self rectForInitialState];
    NSLog(@"NSStringFromCGRect(smallRect) = %@", NSStringFromCGRect(smallRect));

    CGFloat radius = [self distanceToMostFarCornerWithPoint:[self centerPointIn:smallRect] inView:_dismissView];
    bigRect = CGRectInset(smallRect, -radius, -radius);
    NSLog(@"NSStringFromCGRect(bigRect) = %@", NSStringFromCGRect(bigRect));

    UIBezierPath *smallPath = [UIBezierPath bezierPathWithOvalInRect:smallRect];
    UIBezierPath *bigPath = [UIBezierPath bezierPathWithOvalInRect:bigRect];

    //create mask for present view
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = smallPath.CGPath;

    _dismissView.layer.mask = shapeLayer;

    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnimation.fromValue = (id) bigPath.CGPath;
    basicAnimation.toValue = (id) smallPath.CGPath;
    basicAnimation.duration = self.valueObtainer.duration;
    basicAnimation.delegate = self;

    [shapeLayer addAnimation:basicAnimation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.transitionContext) {
        [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];

        if (self.valueObtainer.presenting) {
            _presentView.layer.mask = nil;
        } else {
            _dismissView.layer.mask = nil;
        }
    }
}

- (CGPoint)centerPointIn:(CGRect)rect {
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

///count distance to the most far corner in
- (CGFloat)distanceToMostFarCornerWithPoint:(CGPoint)point inView:(UIView *)view {

    CGPoint result;

    if (point.x <= CGRectGetMidX(view.bounds)) {
        //closer to left
        result.x = CGRectGetWidth(view.bounds) - point.x;
    } else {
        //closer to right
        result.x = point.x;
    }
    if (point.y <= CGRectGetMidY(view.bounds)) {
        result.y = CGRectGetHeight(view.bounds) - point.y;
    } else {
        result.y = point.y;
    }

    return sqrtf((result.x * result.x) + (result.y * result.y));
}

- (CGRect)defaultRectWithSize:(CGFloat)size {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect result = CGRectMake(CGRectGetMidX(screenRect), CGRectGetMidY(screenRect), 0, 0);
    result = CGRectInset(result, 0, 0);
    return result;
}

- (CGRect)rectForInitialState {
    CGRect result;
    UIView *view = nil;

    result = [self defaultRectWithSize:kBCTDefaultRectSize];

    //get corresponding view otherwise try to get another
    if (self.valueObtainer.presenting) {
        view = self.valueObtainer.startPopView ?: self.valueObtainer.endPopView;
    } else {
        view = self.valueObtainer.endPopView ?: self.valueObtainer.startPopView;
    }

    //calculate
    if (view) {
        result = [view convertRect:view.bounds toView:view.window];
        result = CGRectInset(result, CGRectGetWidth(result) / 2.0f, CGRectGetHeight(result) / 2.0f);
    }

    return result;
}

@end
