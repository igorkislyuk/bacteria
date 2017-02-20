//
// Created by Igor on 07/02/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import "BCTTransitioningFactory.h"

#import "BCTTransitioningController.h"
#import "BCTSafariTransitioningController.h"
#import "BCTFlipTransitioningController.h"
#import "BCTPopTransitioningController.h"

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

- (id <UIViewControllerAnimatedTransitioning>)animationControllerWithType:(BCTTransitionType)type {

    switch (type) {

        case BCTTransitionFlatParallel:
        case BCTTransitionFlatCover:
            return [[BCTTransitioningController alloc] initWithValueObtainer:self];

        case BCTTransitionFlip:
            return [[BCTFlipTransitioningController alloc] initWithValueObtainer:self];

        case BCTTransitionSafari:
            return [[BCTSafariTransitioningController alloc] initWithValueObtainer:self];

        case BCTTransitionPopRadial:
        case BCTTransitionPopLinear:
            return [[BCTPopTransitioningController alloc] initWithValueObtainer:self];
    }
}

#pragma mark - Transitioning Delegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.presenting = YES;
    return [self animationControllerWithType:self.presentTransitionType];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.presenting = NO;
    return [self animationControllerWithType:self.dismissTransitionType];
}

@end
