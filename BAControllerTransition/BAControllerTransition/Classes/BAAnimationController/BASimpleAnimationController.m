//
//  AnimationController.m
//  BeautifulAnimationController
//
//  Created by Igor on 24/09/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import "BASimpleAnimationController.h"

#import "BATransitioningController.h"

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

    CGPoint point;
    
    UIView *dismissView = fromVC.view;
    UIView *presentView = toVC.view;
    
    if ([self.transitioningDelegate presenting]) {

        [containerView addSubview:presentView];
        point = self.fromPoint;
        

    } else {
        point = CGPointMake(self.toPoint.x, self.toPoint.y);
        
        [containerView insertSubview:presentView belowSubview:dismissView];
    }

    presentView.transform = CGAffineTransformMakeTranslation(point.x, point.y);
    
    [UIView animateWithDuration:[self.transitioningDelegate duration] animations:^{
        presentView.transform = CGAffineTransformIdentity;
        dismissView.transform = CGAffineTransformMakeTranslation(-point.x, -point.y);
    } completion:^(BOOL finished) {
        
        dismissView.transform = CGAffineTransformIdentity;
        
        [transitionContext completeTransition:YES];
        
    }];
}

@end
