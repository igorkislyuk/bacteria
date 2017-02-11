//
// Created by Igor on 07/02/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import "BCTTransitioningFactory.h"

#import "BCTTransitioningController.h"
#import "BCTSafariTransitioningController.h"
#import "BCTFlipTransitioningController.h"

@implementation BCTTransitioningFactory {
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _startScale = CGSizeMake(1, 1);
        _endScale = CGSizeMake(1, 1);
    }

    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationController {
    if (self.safariLike) {
        return [[BCTSafariTransitioningController alloc] initWithValueObtainer:self];
    } else {

        BCTTransitionType type = self.presenting ? self.presentType : self.dismissType;

        if (type == BCTTransitionTypeFlip) {
            return [[BCTFlipTransitioningController alloc] initWithValueObtainer:self];
        } else {
            return [[BCTTransitioningController alloc] initWithValueObtainer:self];
        }
    }
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
