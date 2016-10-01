//
//  BATransitioningDelegate.m
//  BeautifulAnimationController
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import "BATransitioningDelegate.h"

#import "AnimationController.h"

@interface BATransitioningDelegate ()



@end

@implementation BATransitioningDelegate

- (instancetype)init {
    if (self = [super init]) {
        self.animationController = [[AnimationController alloc] init];
    }
    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.animationController;
}

@end
