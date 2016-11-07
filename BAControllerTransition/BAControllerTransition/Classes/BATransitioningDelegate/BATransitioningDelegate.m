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

@property (nonatomic, strong) BASimpleAnimationController *simpleAnimationController;

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

- (void)preparePresentedFromPoint:(CGPoint)point {
    self.simpleAnimationController.point = point;
}

@end
