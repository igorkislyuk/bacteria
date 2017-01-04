//
//  BCTTransitioningDelegate.m
//  Bacteria
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import "BCTTransitioningController.h"

#import "BCTSimpleAnimationController.h"

@interface BCTTransitioningController ()

@property (nonatomic, strong) BCTSimpleAnimationController *simpleAnimationController;

@end

@implementation BCTTransitioningController {
    BOOL _presenting;
    BCTTransitionType _pType, _dType;
}

- (instancetype)init {
    if (self = [super init]) {
        self.simpleAnimationController = [[BCTSimpleAnimationController alloc] init];
        self.simpleAnimationController.transitioningDelegate = self;
    }
    return self;
}

- (void)dealloc {
//    NSLog(@"%@ - %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
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

#pragma mark - BCTTransitioningDelegate

- (BOOL)presenting {
    return _presenting;
}

- (void)setPresentedType:(BCTTransitionType)type {
    _pType = type;
}

- (void)setDismissedType:(BCTTransitionType)type {
    _dType = type;
}

- (BCTTransitionType)transitionType {
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
