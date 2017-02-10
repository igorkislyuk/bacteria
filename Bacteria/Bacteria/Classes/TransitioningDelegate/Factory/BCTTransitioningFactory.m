//
// Created by Igor on 07/02/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import "BCTTransitioningFactory.h"
#import "BCTSafariTransitioningController.h"
#import "BCTTransitioningController.h"

@implementation BCTTransitioningFactory {
//    BCTTransitioningController *_transitioningController;
//    BCTSafariTransitioningController *_safariTransitioningController;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _startScale = CGSizeMake(1, 1);
        _endScale = CGSizeMake(1, 1);
    }

//    _transitioningController = [[BCTTransitioningController alloc] initWithValueObtainer:self];
//    _safariTransitioningController = [[BCTSafariTransitioningController alloc] initWithValueObtainer:self];

    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationController {
    return self.safariLike ? [[BCTSafariTransitioningController alloc] initWithValueObtainer:self] : [[BCTTransitioningController alloc] initWithValueObtainer:self];
}

#pragma mark - Transitioning Delegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.presenting = YES;
    return [self animationController];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.presenting = NO;
    return [self animationController];
}

@end
