//
//  UIViewController+Bacteria.m
//  Bacteria
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import <objc/runtime.h>

#import "UIViewController+Bacteria.h"

#import "BCTTransitioningController.h"

#import "BCTSimpleAnimationController.h"

@interface UIViewController (Bacteria_Private)

@property(nonatomic, strong) BCTTransitioningController *bctTransitioningDelegate;

@end

@implementation UIViewController (Bacteria_Private)

- (void)setBCTTransitioningDelegate {
    if (![self.transitioningDelegate isEqual:self.bctTransitioningDelegate]) {
        self.transitioningDelegate = self.bctTransitioningDelegate;
    }
}

#pragma mark - Properties

- (void)setBctTransitioningDelegate:(BCTTransitioningController *)baTransitioningDelegate {
    objc_setAssociatedObject(self, @selector(bctTransitioningDelegate), baTransitioningDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BCTTransitioningController *)bctTransitioningDelegate {
    BCTTransitioningController *transitioningDelegate = objc_getAssociatedObject(self, @selector(bctTransitioningDelegate));

    if (transitioningDelegate == nil) {
        transitioningDelegate = [[BCTTransitioningController alloc] init];
        [self setBctTransitioningDelegate:transitioningDelegate];
    }

    return transitioningDelegate;
}

@end

@implementation UIViewController (Bacteria)

- (BCTControllerTransitionLocation)fromPoint {
    BCTControllerTransitionLocation fromLocation = BCTControllerTransitionLocation(point) {

        //just move from point
        [[self bctTransitioningDelegate] preparePresentedFromPoint:point];

        return self;
    };
    return fromLocation;
}

- (BCTControllerTransitionLocation)toPoint {
    BCTControllerTransitionLocation toPoint = BCTControllerTransitionLocation(point) {

        [[self bctTransitioningDelegate] prepareDismissedToPoint:point];

        return self;
    };
    return toPoint;
}

- (BCTControllerTransitionType)withPresentedTransitionType {
    BCTControllerTransitionType transitionType = BCTControllerTransitionType(type) {
        [[self bctTransitioningDelegate] setPresentedType:type];
        return self;
    };
    return transitionType;
}

- (BCTControllerTransitionType)withDismissedTransitionType {
    BCTControllerTransitionType transitionType = BCTControllerTransitionType(type) {
        [[self bctTransitioningDelegate] setDismissedType:type];
        return self;
    };
    return transitionType;
}

- (BCTControllerTransitionSideType)presentFrom {
    BCTControllerTransitionSideType plainFrom = BCTControllerTransitionSideType(sideType) {

        //save
        [[self bctTransitioningDelegate] setPresentedSideType:sideType];

        CGPoint fromPoint = CGPointZero;

        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat height = CGRectGetHeight(self.view.bounds);

        switch (sideType) {
            case BCTTransitionSideTypeLeft:
                fromPoint = CGPointMake(-width, 0);
                break;
            case BCTTransitionSideTypeRight:
                fromPoint = CGPointMake(width, 0);
                break;
            case BCTTransitionSideTypeTop:
                fromPoint = CGPointMake(0, -height);
                break;
            case BCTTransitionSideTypeBottom:
                fromPoint = CGPointMake(0, height);
                break;
            case BCTTransitionSideTypeTopLeftCorner:
                fromPoint = CGPointMake(-width, -height);
                break;
            case BCTTransitionSideTypeTopRightCorner:
                fromPoint = CGPointMake(width, -height);
                break;
            case BCTTransitionSideTypeBottomLeftCorner:
                fromPoint = CGPointMake(-width, height);
                break;
            case BCTTransitionSideTypeBottomRightCorner:
                fromPoint = CGPointMake(width, height);
                break;
        }

        [[self bctTransitioningDelegate] preparePresentedFromPoint:fromPoint];

        return self;
    };
    return plainFrom;
}

- (BCTControllerTransitionSideType)dismissTo {
    BCTControllerTransitionSideType plainTo = BCTControllerTransitionSideType(sideType) {

        //save
        [[self bctTransitioningDelegate] setDismissedSideType:sideType];

        CGPoint toPoint = CGPointZero;

        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat height = CGRectGetHeight(self.view.bounds);

        switch (sideType) {

            case BCTTransitionSideTypeLeft:
                toPoint = CGPointMake(-width, 0);
                break;
            case BCTTransitionSideTypeRight:
                toPoint = CGPointMake(width, 0);
                break;
            case BCTTransitionSideTypeTop:
                toPoint = CGPointMake(0, -height);
                break;
            case BCTTransitionSideTypeBottom:
                toPoint = CGPointMake(0, height);
                break;
            case BCTTransitionSideTypeTopLeftCorner:
                toPoint = CGPointMake(-width, -height);
                break;
            case BCTTransitionSideTypeTopRightCorner:
                toPoint = CGPointMake(width, -height);
                break;
            case BCTTransitionSideTypeBottomLeftCorner:
                toPoint = CGPointMake(-width, height);
                break;
            case BCTTransitionSideTypeBottomRightCorner:
                toPoint = CGPointMake(width, height);
                break;
        }

        [[self bctTransitioningDelegate] prepareDismissedToPoint:toPoint];


        return self;
    };
    return plainTo;
}

- (BCTControllerTransitionTime)transite {
    BCTControllerTransitionTime ttime = BCTControllerTransitionTime(time) {
        //set delegate
        [self setBCTTransitioningDelegate];

        self.bctTransitioningDelegate.duration = time;

        return self;
    };
    return ttime;
}

- (BCTControllerTransitionEmpty)reverse {
    return ^UIViewController * {

        BCTTransitionSideType dismissedSideType = self.bctTransitioningDelegate.dismissedSideType;
        BCTTransitionSideType presentedSideType = self.bctTransitioningDelegate.presentedSideType;

        if (presentedSideType && !dismissedSideType) {
            self.dismissTo(presentedSideType);
        } else if (!presentedSideType && dismissedSideType) {
            self.presentFrom(dismissedSideType);
        } else {
            //do nothing
        }
        return self;
    };
}

#pragma mark - Test methods

- (void)presentTestAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Test message" message:@"This message from framework" preferredStyle:UIAlertControllerStyleAlert];

    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];

    [self presentViewController:alertController animated:YES completion:nil];
}

@end
