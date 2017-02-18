//
// Created by Igor on 12/02/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import "BCTPopTransitioningController.h"

const float kBCTDefaultRectSize = 100.0f;
static NSString *kBCTAnimationViewStoring = @"kAnimationViewStoring";

@interface BCTPopTransitioningController () <CAAnimationDelegate>

@property(nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;

@end

@implementation BCTPopTransitioningController {
    UIView *_presentView, *_dismissView;
}

// todo: reorganize methods here

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

    //animation section
    CGRect smallRect, bigRect;
    smallRect = [self rectForInitialState];
    CGFloat radius = [self distanceToMostFarCornerWithPoint:[self centerPointIn:smallRect] inView:containerView];
    bigRect = CGRectInset(smallRect, -radius, -radius);
    UIBezierPath *smallPath = [UIBezierPath bezierPathWithOvalInRect:smallRect];
    UIBezierPath *bigPath = [UIBezierPath bezierPathWithOvalInRect:bigRect];

    if (self.valueObtainer.presenting) {

        [self animateShapeMaskFor:_presentView withStartPath:bigPath toEndPath:smallPath];
    } else {

        [containerView bringSubviewToFront:_dismissView];

        [self animateShapeMaskFor:_dismissView withStartPath:smallPath toEndPath:bigPath];

    }

}

- (void)animateShapeMaskFor:(UIView *)view withStartPath:(UIBezierPath *)endPath toEndPath:(UIBezierPath *)startPath {

    //create mask for present view
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = endPath.CGPath;

    view.layer.mask = shapeLayer;

    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnimation.fromValue = (id) startPath.CGPath;
    basicAnimation.toValue = (id) endPath.CGPath;
    basicAnimation.duration = self.valueObtainer.duration;
    basicAnimation.delegate = self;

    [basicAnimation setValue:view forKey:kBCTAnimationViewStoring];

    [shapeLayer addAnimation:basicAnimation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.transitionContext) {
        [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];

        UIView *view = [anim valueForKey:kBCTAnimationViewStoring];
        view.layer.mask = nil;

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
