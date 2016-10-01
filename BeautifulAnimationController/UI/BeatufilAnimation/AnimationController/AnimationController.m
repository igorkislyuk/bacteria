//
//  AnimationController.m
//  BeautifulAnimationController
//
//  Created by Igor on 24/09/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import "AnimationController.h"
#import "FirstViewController.h"

@interface AnimationController ()

@end

@implementation AnimationController

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 2.0f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    UIView *containerView = [transitionContext containerView];


    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;

    FirstViewController *fromVC = (FirstViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    UIView *fromView = fromVC.view;

    NSLog(@"NSStringFromCGRect(containerView.frame) = %@", NSStringFromCGRect(containerView.frame));

    [containerView addSubview:toView];

    //get viewAfterScreenUpdates
    UIView *viewAfterScreenUpdates = [fromVC.label snapshotViewAfterScreenUpdates:YES];
    [fromVC.label setHidden:YES];
    [containerView addSubview:viewAfterScreenUpdates];

    [viewAfterScreenUpdates setFrame:fromVC.label.frame];

    toView.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(toView.frame), 0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         toView.transform = CGAffineTransformIdentity;
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                         
                         [viewAfterScreenUpdates removeFromSuperview];
                         [fromVC.label setHidden:NO];
                     }];


}


@end
