//
//  BATransitioningDelegate.m
//  BeautifulAnimationController
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import "BATransitioningController.h"

#import "BASimpleAnimationController.h"

@interface BATransitioningController ()

@property (nonatomic, strong) BASimpleAnimationController *simpleAnimationController;

@end

@implementation BATransitioningController {
    BOOL _presenting;
    BATransitionType _pType, _dType;
}

- (instancetype)init {
    if (self = [super init]) {
        self.simpleAnimationController = [[BASimpleAnimationController alloc] init];
        self.simpleAnimationController.transitioningDelegate = self;
    }
    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    _presenting = YES;
    return self.simpleAnimationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _presenting = NO;
    return self.simpleAnimationController;
}

#pragma mark - BATransitioningDelegate

- (BOOL)presenting {
    return _presenting;
}

- (void)setPresentedType:(BATransitionType)type {
    _pType = type;
}

- (void)setDismissedType:(BATransitionType)type {
    _dType = type;
}

- (BATransitionType)transitionType {
    return _presenting ? _pType : _dType;
}


#pragma mark - Methods

- (void)preparePresentedFromPoint:(CGPoint)point {
    self.simpleAnimationController.fromPoint = point;
}

- (void)prepareDismissedToPoint:(CGPoint)point {
    self.simpleAnimationController.toPoint = point;
}

@end
