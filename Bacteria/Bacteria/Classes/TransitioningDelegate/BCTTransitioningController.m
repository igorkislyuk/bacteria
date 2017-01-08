//
//  BCTTransitioningDelegate.m
//  Bacteria
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import "BCTTransitioningController.h"
#import "BCTParallelLocationPerformer.h"


@interface BCTTransitioningController ()

@property (nonatomic) id<BCTViewPerformer> locationPerformer;

@end

@implementation BCTTransitioningController {
    BOOL _presenting;
    BCTTransitionType _pType, _dType;
    CGPoint _startPoint, _endPoint;
    UIView *_dismissView, *_presentView;

    CGSize _startScale, _endScale;
}

- (instancetype)init {
    self = [super init];
    if (self) {

        _startScale = CGSizeMake(1, 1);
        _endScale = CGSizeMake(1, 1);

    }

    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    _presenting = YES;
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _presenting = NO;
    return self;
}

#pragma mark - Animated transitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

//    //get start values
//    UIView *containerView = [transitionContext containerView];
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//
//    //Moves from start to end
//    _startPoint = CGPointZero;
//    _endPoint = CGPointZero;
//    _dismissView = fromVC.view;
//    _presentView = toVC.view;
//
//    if (_presenting) {
//
//        [containerView addSubview:_presentView];
//
//        _startPoint = self.fromPoint;
//    } else {
//
//        _endPoint = self.toPoint;
//
//        [containerView insertSubview:_presentView belowSubview:_dismissView];
//    }
//
//    switch (self.transitionType) {
//        case BCTTransitionTypeParallel:
//            [self parallelTransition:transitionContext];
//            break;
//        case BCTTransitionTypeCover:
//            [self coverTransition:transitionContext];
//            break;
//        default:
//            NSLog(@"support this type of transition");
//    }


    //perform simple object wrapping

    //get start values
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    //Moves from start to end
    _startPoint = CGPointZero;
    _endPoint = CGPointZero;
    _dismissView = fromVC.view;
    _presentView = toVC.view;

//    if (_presenting) {
    [containerView addSubview:_presentView];
    _startPoint = self.presentFromPoint;
//    } else {
//        _endPoint = self.toPoint;
//        [containerView insertSubview:_presentView belowSubview:_dismissView];
//    }

    CGPoint point = CGPointMake(_startPoint.x - _endPoint.x, _startPoint.y - _endPoint.y);

//    CGAffineTransform originPTransform = _presentView.transform;
//    CGAffineTransform originDTransform = _dismissView.transform;

    //create performer
    self.locationPerformer = [[BCTParallelLocationPerformer alloc] initWithPresentedView:_presentView dismissedView:_dismissView];

    self.locationPerformer.offsetPoint = point;
    self.locationPerformer.startScale = _startScale;
    self.locationPerformer.endScale = _endScale;

//    _presentView.transform = CGAffineTransformTranslate(originPTransform, dx, dy);
    _presentView = [self.locationPerformer presentedViewBefore];

    [UIView animateWithDuration:self.duration animations:^{

//        _presentView.transform = originPTransform;
        _presentView = [self.locationPerformer presentedViewAfter];

//        _dismissView.transform = CGAffineTransformTranslate(originDTransform, -dx, -dy);
        [self.locationPerformer dismissedViewAfter];

    }                completion:^(BOOL finished) {

//        _dismissView.transform = originDTransform;
        [self.locationPerformer dismissedViewBefore];

        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];

    }];
}

- (void)setPresentedType:(BCTTransitionType)type {
    _pType = type;
}

- (void)setDismissedType:(BCTTransitionType)type {
    _dType = type;
}

- (void)setStartScale:(CGSize)scale {
    _startScale = scale;
}

- (void)setEndScale:(CGSize)scale {
    _endScale = scale;
}


- (BCTTransitionType)transitionType {
    return _presenting ? _pType : _dType;
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
    if (_presenting) {
        view = _presentView;
    } else {
        view = _dismissView;
        dx = -dx;
        dy = -dy;
    }

    [self cover_animatePresentedView:view dx:dx dy:dy reversed:!_presenting inAnimationBlock:nil inCompletionBlock:block];

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

    [UIView animateWithDuration:self.duration animations:^{

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

    [UIView animateWithDuration:self.duration animations:^{

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

#pragma mark - Performers

- (id <BCTViewPerformer>)locationPerformerOfType:(BCTTransitionType)transitionType {

    return [[BCTParallelLocationPerformer alloc] init];

}

@end
