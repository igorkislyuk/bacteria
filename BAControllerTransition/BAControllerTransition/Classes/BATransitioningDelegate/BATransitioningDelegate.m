//
//  BATransitioningDelegate.m
//  BeautifulAnimationController
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import "BATransitioningDelegate.h"

#import "BASimpleAnimationController.h"

@interface BATransitioningDelegate ()



@end

@implementation BATransitioningDelegate

- (instancetype)init {
    if (self = [super init]) {
        self.simpleAnimationController = [[BASimpleAnimationController alloc] init];
        self.simpleAnimationController.transitioningDelegate = self;
    }
    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.simpleAnimationController;
}

#pragma mark - Methods

- (void)setTime:(NSTimeInterval)timeInterval {
    _duration = timeInterval;
}

- (void)preparePresentedFrom:(CGFloat)rightSideTrailingSpace {
    [[self simpleAnimationController] setDistanceFromRight:rightSideTrailingSpace];
}

@end
