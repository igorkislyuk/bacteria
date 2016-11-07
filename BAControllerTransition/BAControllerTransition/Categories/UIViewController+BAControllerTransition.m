//
//  UIViewController+BAAnimationController.m
//  BeautifulAnimationController
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import <objc/runtime.h>

#import "UIViewController+BAControllerTransition.h"

#import "BATransitioningController.h"

#import "BASimpleAnimationController.h"

@interface UIViewController (BAControllerTransition_Private)

@property (nonatomic, strong) BATransitioningController *baTransitioningDelegate;

@end

@implementation UIViewController (BAControllerTransition_Private)

- (void)setBATransitioningDelegate {
    if (![self.transitioningDelegate isEqual:self.baTransitioningDelegate]) {
        self.transitioningDelegate = self.baTransitioningDelegate;
    }
}

- (void)addConfiguration {
    
}

#pragma mark - Properties

- (void)setBaTransitioningDelegate:(BATransitioningController *)baTransitioningDelegate {
    objc_setAssociatedObject(self, @selector(baTransitioningDelegate), baTransitioningDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BATransitioningController *)baTransitioningDelegate {
    BATransitioningController* transitioningDelegate = objc_getAssociatedObject(self, @selector(baTransitioningDelegate));
    
    if (transitioningDelegate == nil) {
        transitioningDelegate = [[BATransitioningController alloc] init];
        [self setBaTransitioningDelegate:transitioningDelegate];
    }
    
    return transitioningDelegate;
}

@end

@implementation UIViewController (BAControllerTransition)

//main implementation here

- (BAControllerTransitionLocation)fromPoint {
    BAControllerTransitionLocation fromLocation = BAControllerTransitionLocation(point) {

        //just move from point
        [[self baTransitioningDelegate] preparePresentedFromPoint:point];

        return self;
    };
    return fromLocation;
}

- (BAControllerTransitionEmpty)fromRightSide {
    BAControllerTransitionEmpty fromRightSide = BAControllerTransitionEmpty() {

        //just move from right side
        CGFloat right = CGRectGetWidth(self.view.bounds);
        [[self baTransitioningDelegate] preparePresentedFromPoint:CGPointMake(right, 0)];

        return self;

    };
    return fromRightSide;
}
- (BAControllerTransitionEmpty)fromLeftSide {
    BAControllerTransitionEmpty fromLeftSide = BAControllerTransitionEmpty() {

        //just move from left side
        CGFloat left = -CGRectGetWidth(self.view.bounds);
        [[self baTransitioningDelegate] preparePresentedFromPoint:CGPointMake(left, 0)];

        return self;
    };
    return fromLeftSide;
}
- (BAControllerTransitionEmpty)fromTopSide {
    BAControllerTransitionEmpty fromTopSide = BAControllerTransitionEmpty() {

        //just move from top side
        CGFloat top = -CGRectGetHeight(self.view.bounds);
        [[self baTransitioningDelegate] preparePresentedFromPoint:CGPointMake(0, top)];

        return self;
    };
    return fromTopSide;
}
- (BAControllerTransitionEmpty)fromBottomSide {
    BAControllerTransitionEmpty fromBottomSide = BAControllerTransitionEmpty() {

        //just move from bottom side
        CGFloat bottom = CGRectGetHeight(self.view.bounds);
        [[self baTransitioningDelegate] preparePresentedFromPoint:CGPointMake(0, bottom)];

        return self;
    };
    return fromBottomSide;
}

- (BAControllerTransitionLocation)toPoint {
    BAControllerTransitionLocation toPoint = BAControllerTransitionLocation(point) {

        [[self baTransitioningDelegate] prepareDismissedToPoint:point];

        return self;
    };
    return toPoint;
}

- (BAControllerTransitionTime)transite {
    BAControllerTransitionTime ttime = BAControllerTransitionTime(time) {
        //set delegate
        [self setBATransitioningDelegate];
        
        self.baTransitioningDelegate.duration = time;
        
        return self;
    };
    return ttime;
}


#pragma mark - Test methods

- (void)presentTestAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Test message" message:@"This message from framework" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
