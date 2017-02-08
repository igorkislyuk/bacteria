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

@implementation BCTSafariTransitioningController

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

    UIView *newSnapshotView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    [containerView addSubview:newSnapshotView];

    //remove
    [fromVC.view removeFromSuperview];

    //interval
    NSTimeInterval duration = self.valueObtainer.duration / 2;

    //animation part 1
    CABasicAnimation *oldAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];

    CATransform3D transform3D = oldSnapshotView.layer.transform;
    oldAnimation.fromValue = [NSValue valueWithCATransform3D:transform3D];
    oldAnimation.toValue = [NSValue valueWithCATransform3D:[self transformForPageWith:transform3D]];
    oldAnimation.duration = duration;
    oldAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

//    oldAnimation.delegate = self;
    [oldSnapshotView.layer addAnimation:oldAnimation forKey:nil];

    //animation part 2
    CABasicAnimation *newAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];

    CATransform3D newTransform = newSnapshotView.layer.transform;
    newTransform = [self transformForPageWith:newTransform];
    newTransform = CATransform3DTranslate(newTransform, 0, [[UIScreen mainScreen] bounds].size.height - 100.f, 0);
    
    newSnapshotView.layer.transform = newTransform;
    
    newAnimation.fromValue = [NSValue valueWithCATransform3D:newTransform];
    newAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    newAnimation.duration = duration;
    newAnimation.beginTime = CACurrentMediaTime() + duration;
    newAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    newAnimation.delegate = self;

    [newSnapshotView.layer addAnimation:newAnimation forKey:nil];

    [self.viewsToRemove addObject:oldSnapshotView];
    [self.viewsToAdd addObject:toVC.view];

    //create animation

    self.transitionContext = transitionContext;
}

- (CATransform3D)transformForPageWith:(CATransform3D)transform3D {
    CATransform3D result = transform3D;
    result = CATransform3DScale(transform3D, 0.8, 0.75, 0.9);
    result = CATransform3DRotate(transform3D, DEGREES_TO_RADIANS(-25), 1, 0, 0);
    return result;
}

#pragma mark - Animation Delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"%s", sel_getName(_cmd));

    for (UIView *view in self.viewsToRemove) {
        [view removeFromSuperview];
    }

    for (UIView *add in self.viewsToAdd) {
        [[self.transitionContext containerView] addSubview:add];
    }

    [self.transitionContext completeTransition:YES];

}


@end
