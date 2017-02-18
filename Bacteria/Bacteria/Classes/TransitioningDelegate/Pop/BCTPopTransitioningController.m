//
// Created by Igor on 12/02/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import "BCTPopTransitioningController.h"

static NSString *kBCTAnimationViewStoring = @"kAnimationViewStoring";
const float kBCTDefaultCornerSize = 10.f;

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

    UIBezierPath *smallPath, *bigPath;

    if ([self transitionType] == BCTTransitionPopRadial) {
        smallRect = [self initialZeroSizedRect:YES];

        CGFloat radius = [self distanceToMostFarCornerWithPoint:[self centerPointIn:smallRect] inView:containerView];
        bigRect = CGRectInset(smallRect, -radius, -radius);

        smallPath = [UIBezierPath bezierPathWithOvalInRect:smallRect];
        bigPath = [UIBezierPath bezierPathWithOvalInRect:bigRect];
    } else {
        //for linear

        smallRect = [self initialZeroSizedRect:NO];
        bigRect = [containerView bounds];

        CGFloat size = [self size];

        bigRect = CGRectInset(bigRect, -size, -size);

        smallPath = [UIBezierPath bezierPathWithRoundedRect:smallRect cornerRadius:size];
        bigPath = [UIBezierPath bezierPathWithRoundedRect:bigRect cornerRadius:size];
    }

    if (self.valueObtainer.presenting) {

        [self animateShapeMaskFor:_presentView withStartPath:bigPath toEndPath:smallPath];
    } else {

        [containerView bringSubviewToFront:_dismissView];

        [self animateShapeMaskFor:_dismissView withStartPath:smallPath toEndPath:bigPath];

    }

}

- (CGFloat)size {
    CGFloat result = kBCTDefaultCornerSize;

    if ([self popView]) {
        result = [self popView].layer.cornerRadius;
    }

    return result;
}

- (BCTTransitionType)transitionType {
    return self.valueObtainer.presenting ? self.valueObtainer.presentTransitionType : self.valueObtainer.dismissTransitionType;
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

- (CGRect)defaultRect {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect result = CGRectMake(CGRectGetMidX(screenRect), CGRectGetMidY(screenRect), 0, 0);
    result = CGRectInset(result, 0, 0);
    return result;
}

- (CGRect)initialZeroSizedRect:(BOOL)zeroSized {
    CGRect result;
    UIView *view = nil;

    result = [self defaultRect];
    view = [self popView];

    //calculate
    if (view) {
        result = [view convertRect:view.bounds toView:view.window];
    }

    if (zeroSized) {
        result = CGRectInset(result, CGRectGetWidth(result) / 2.0f, CGRectGetHeight(result) / 2.0f);
    }

    return result;
}

- (UIView *)popView {
    UIView *view;//get corresponding view otherwise try to get another
    if (self.valueObtainer.presenting) {
        view = self.valueObtainer.startPopView ?: self.valueObtainer.endPopView;
    } else {
        view = self.valueObtainer.endPopView ?: self.valueObtainer.startPopView;
    }
    return view;
}

@end
