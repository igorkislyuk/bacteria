//
// Created by Igor on 07/02/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#define DEGREES_TO_RADIANS(degrees) (CGFloat)((M_PI * degrees)/180.f)

#import "BCTSafariTransitioningController.h"

#import "BCTTransitioning.h"

@interface BCTSafariTransitioningController () <CAAnimationDelegate>

@property(nonatomic, assign) BOOL presenting;

@property(nonatomic, strong) id <UIViewControllerContextTransitioning> transitionContext;

@property(nonatomic, strong) NSMutableSet *viewsToRemove;
@property(nonatomic, strong) NSMutableArray *viewsToAdd;

@end

@implementation BCTSafariTransitioningController {
    CABasicAnimation *_appearAnimation, *_dismissAnimation;
}

- (instancetype)initWithValueObtainer:(id <BCTTransitioning>)valueObtainer {
    self = [super init];
    if (self) {
        _valueObtainer = valueObtainer;
        _viewsToAdd = [[NSMutableArray alloc] init];
        _viewsToRemove = [[NSMutableSet alloc] init];
    }

    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.presenting = YES;
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.presenting = NO;
    return nil;
}

#pragma mark - Animated transitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return self.valueObtainer.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    //get start values
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    //perspective
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = 1.f / -1800.f;
    containerView.layer.sublayerTransform = perspective;

    //create snaps
    UIView *oldSnapshotView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    [containerView addSubview:oldSnapshotView];

    oldSnapshotView.layer.zPosition = 0;
    

    UIView *newSnapshotView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    [containerView insertSubview:newSnapshotView aboveSubview:oldSnapshotView];
    newSnapshotView.layer.zPosition = 1.f;

    //remove
    [fromVC.view removeFromSuperview];

    //interval
    NSTimeInterval duration = self.valueObtainer.duration / 2;

    //animation part 1

    CABasicAnimation *oldAnimation = [self animationForDismissingViewWithDuration:duration];
    oldSnapshotView.layer.transform = [self transformForPage];
    [oldSnapshotView.layer addAnimation:oldAnimation forKey:nil];

    //animation part 2
    
    CATransform3D startTransform = CATransform3DConcat([self transformForPage], CATransform3DMakeTranslation(0, 600, 0));
    
    newSnapshotView.layer.transform = startTransform;
    CABasicAnimation *newAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    newAnimation.fromValue = [NSValue valueWithCATransform3D:startTransform];
    newAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    newAnimation.duration = duration;
    newAnimation.beginTime = CACurrentMediaTime() + duration;
    newAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    newAnimation.removedOnCompletion = NO;
    newAnimation.delegate = self;
//
    [newSnapshotView.layer addAnimation:newAnimation forKey:nil];
    
    //animation for move layer up
    CABasicAnimation *moveOldUpAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    moveOldUpAnimation.fromValue = [NSValue valueWithCATransform3D:oldSnapshotView.layer.transform];
    moveOldUpAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DTranslate(oldSnapshotView.layer.transform, 0, -1200, 0)];
    moveOldUpAnimation.duration = duration;
    moveOldUpAnimation.beginTime = CACurrentMediaTime() + duration;
    moveOldUpAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [oldSnapshotView.layer addAnimation:moveOldUpAnimation forKey:nil];
    

    //delay
    [self.viewsToRemove addObject:oldSnapshotView];
    [self.viewsToRemove addObject:newSnapshotView];

    [self.viewsToAdd addObject:toVC.view];

    self.transitionContext = transitionContext;
}

- (CABasicAnimation *)animationForDismissingViewWithDuration:(NSTimeInterval)duration {
    CABasicAnimation *oldAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];

    oldAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    oldAnimation.toValue = [NSValue valueWithCATransform3D:[self transformForPage]];
    oldAnimation.duration = duration;
    oldAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
//    oldAnimation.delegate = self;

    return oldAnimation;
}

- (CATransform3D)transformForPage {
    // were 0.8 & 0.75
    CATransform3D scale = CATransform3DMakeScale(0.8, 0.75, 0.9);
    CATransform3D rotate = CATransform3DMakeRotation(DEGREES_TO_RADIANS(-25), 1, 0, 0);
    return CATransform3DConcat(scale, rotate);
}

#pragma mark - Animation Delegate

- (void)animationDidStart:(CAAnimation *)anim {

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"%s", sel_getName(_cmd));

    for (UIView *add in self.viewsToAdd) {
        [[self.transitionContext containerView] addSubview:add];
        [[self.transitionContext containerView] bringSubviewToFront:add];
    }
    
    for (UIView *view in self.viewsToRemove) {
        [view removeFromSuperview];
    }

    [self.transitionContext completeTransition:YES];

}


@end
