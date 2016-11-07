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
@property (nonatomic, assign) CGFloat top;

@end

@implementation BASimpleAnimationController {
    CGPoint _point;
}

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
    
    toVC.view.transform = CGAffineTransformMakeTranslation(self.point.x, self.point.y);
    
    [UIView animateWithDuration:[self.transitioningDelegate duration] animations:^{
        toVC.view.transform = CGAffineTransformIdentity;
        fromVC.view.transform = CGAffineTransformMakeTranslation(-self.point.x, -self.point.y);
    } completion:^(BOOL finished) {
        
        fromVC.view.transform = CGAffineTransformIdentity;
        
        [transitionContext completeTransition:YES];
        
    }];
}

@end
