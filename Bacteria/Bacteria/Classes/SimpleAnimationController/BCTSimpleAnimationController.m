//
//  BCTSimpleAnimationController.m
//  Bacteria
//
//  Created by Igor on 24/09/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import "BCTSimpleAnimationController.h"

#import "BCTTransitioningController.h"

@interface BCTSimpleAnimationController ()

@property(nonatomic, assign) CGFloat right;
@property(nonatomic, assign) CGFloat top;

@end

@implementation BCTSimpleAnimationController {
    CGPoint _startPoint, _endPoint;
    UIView *_dismissView, *_presentView;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return [self.transitioningDelegate duration];
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    //get start values
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    //Moves from start to end
    _startPoint = CGPointZero;
    _endPoint = CGPointZero;
    _dismissView = fromVC.view;
    _presentView = toVC.view;

    BOOL presenting = [self.transitioningDelegate presenting];
    if (presenting) {

        [containerView addSubview:_presentView];

        _startPoint = self.fromPoint;
    } else {

        _endPoint = self.toPoint;

        [containerView insertSubview:_presentView belowSubview:_dismissView];
    }

    switch ([self.transitioningDelegate transitionType]) {
        case BCTTransitionTypeParallel:
            [self parallelTransition:transitionContext];
            break;
        case BCTTransitionTypeCover:
            [self coverTransition:transitionContext];
            break;
        default:
            NSLog(@"support this type of transition");
    }

}

- (void)parallelTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    CGFloat dx = _startPoint.x - _endPoint.x;
    CGFloat dy = _startPoint.y - _endPoint.y;

    void (^block)(BOOL)=^(BOOL finished) {
        [transitionContext completeTransition:YES];
    };

    [self parallel_animatePresentedView:_presentView dismissedView:_dismissView dx:dx dy:dy inAnimationBlock:nil inCompletionBlock:block];
}

- (void)coverTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    CGFloat dx, dy;

    void (^block)(BOOL)=^(BOOL finished) {
        [transitionContext completeTransition:YES];
    };
        dx = _startPoint.x - _endPoint.x;
        dy = _startPoint.y - _endPoint.y;

    UIView *view;
    BOOL presenting = [self.transitioningDelegate presenting];
    if (presenting) {
        view = _presentView;
    } else {
        view = _dismissView;
        dx = -dx;
        dy = -dy;
    }

    [self cover_animatePresentedView:view dx:dx dy:dy reversed:!presenting inAnimationBlock:nil inCompletionBlock:block];

}

#pragma mark - Methods for animate in different behaviours

/**
 * Moves presented in and dismissed out
 * @param presentedView
 * @param dismissedView
 * @param dx
 * @param dy
 * @param aBlock
 * @param cBlock
 */
- (void)parallel_animatePresentedView:(UIView *)presentedView dismissedView:(UIView *)dismissedView
                                   dx:(CGFloat)dx dy:(CGFloat)dy
                     inAnimationBlock:(void (^)())aBlock inCompletionBlock:(void (^)(BOOL))cBlock {

    CGAffineTransform originPTransform = presentedView.transform;
    CGAffineTransform originDTransform = dismissedView.transform;

    presentedView.transform = CGAffineTransformTranslate(originPTransform, dx, dy);

    [UIView animateWithDuration:[self.transitioningDelegate duration] animations:^{

        presentedView.transform = originPTransform;

        dismissedView.transform = CGAffineTransformTranslate(originDTransform, -dx, -dy);

        if (aBlock) {
            aBlock();
        }

    }                completion:^(BOOL finished) {

        dismissedView.transform = originDTransform;

        if (cBlock) {
            cBlock(finished);
        }

    }];
}

/**
 * Originally transform and then bring to Identity. Reversed: Identity -> transformed
 * @param presentedView 
 * @param dx 
 * @param dy 
 * @param reversed 
 * @param aBlock 
 * @param cBlock 
 */
- (void)cover_animatePresentedView:(UIView *)presentedView dx:(CGFloat)dx dy:(CGFloat)dy reversed:(BOOL)reversed inAnimationBlock:(void (^)())aBlock inCompletionBlock:(void (^)(BOOL))cBlock {

    CGAffineTransform originPTransform = presentedView.transform;

    if (!reversed) {
        presentedView.transform = CGAffineTransformTranslate(originPTransform, dx, dy);
    }

    [UIView animateWithDuration:[self.transitioningDelegate duration] animations:^{
        
        presentedView.transform = reversed ? CGAffineTransformTranslate(originPTransform, dx, dy) : originPTransform;

        if (aBlock) {
            aBlock();
        }

    }                completion:^(BOOL finished) {

        if (cBlock) {
            cBlock(finished);
        }

    }];
}

- (void)dealloc {
//    NSLog(@"%@ - %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

@end
