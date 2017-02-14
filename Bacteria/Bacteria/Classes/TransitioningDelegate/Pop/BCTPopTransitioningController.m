//
// Created by Igor on 12/02/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import "BCTPopTransitioningController.h"

const float kBCTDefaultRectSize = -100.0f;

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

    //get start values
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    [containerView addSubview:toVC.view];

    _dismissView = fromVC.view;
    _presentView = toVC.view;

    UIView *startPopView = self.valueObtainer.startPopView;

    CGRect oldRect, newRect;

    if (startPopView) {

        if ([startPopView.superview isEqual:_dismissView]) {
            oldRect = startPopView.frame;
        } else if ([startPopView isDescendantOfView:_dismissView]) {
            oldRect = [startPopView convertRect:startPopView.bounds toView:_dismissView];
        } else {
            //unknown behaviour -> fallback to zero
            oldRect = [self defaultRectWithSize:kBCTDefaultRectSize];
        }

    } else {
        oldRect = [self defaultRectWithSize:kBCTDefaultRectSize];
    }

    CGFloat radius = [self distanceToMostFarCornerWithPoint:[self centerPointIn:oldRect] inView:_dismissView];

    newRect = CGRectInset(oldRect, -radius, -radius);
    NSLog(@"NSStringFromCGRect(newRect) = %@", NSStringFromCGRect(newRect));

    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:oldRect];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:newRect];

    //create mask for present view
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = endPath.CGPath;
    _presentView.layer.mask = shapeLayer;

    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnimation.fromValue = (id) startPath.CGPath;
    basicAnimation.toValue = (id) endPath.CGPath;
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

- (CGPoint)centerPointIn:(CGRect)rect {
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

//count distance to the most far corner in
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
    result = CGRectInset(result, -size, -size);
    NSLog(@"screenRect = %@", NSStringFromCGRect(result));
    return result;
}

@end
