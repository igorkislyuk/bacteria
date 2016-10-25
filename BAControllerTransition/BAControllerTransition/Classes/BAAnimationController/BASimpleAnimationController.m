//
//  AnimationController.m
//  BeautifulAnimationController
//
//  Created by Igor on 24/09/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import "BASimpleAnimationController.h"

#import "BATransitioningDelegate.h"

@interface BASimpleAnimationController ()

@property (nonatomic, assign) CGFloat right;

@end

@implementation BASimpleAnimationController

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return [self.transitioningDelegate duration];
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    UIView *containerView = [transitionContext containerView];

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //configure fromVC
    [containerView addSubview:toVC.view];

    CGFloat tx = self.right;
    toVC.view.transform = CGAffineTransformMakeTranslation(tx, 0);
    
    [UIView animateWithDuration:[self.transitioningDelegate duration] animations:^{
        toVC.view.transform = CGAffineTransformIdentity;
        fromVC.view.transform = CGAffineTransformMakeTranslation(-tx, 0);
    } completion:^(BOOL finished) {
        //TODO: check values
        [transitionContext completeTransition:YES];
    }];
}

- (void)setDistanceFromRight:(CGFloat)right {
    self.right = right;
}

@end
