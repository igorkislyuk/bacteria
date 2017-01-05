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

@interface UIViewController (Bacteria_Private)

@property(nonatomic, strong) BCTTransitioningController *transitioningController;

@end

@implementation UIViewController (Bacteria_Private)

- (void)setTransitioningDelegate {
    if (![self.transitioningDelegate isEqual:self.transitioningController]) {
        self.transitioningDelegate = self.transitioningController;
    }
}

#pragma mark - Properties

- (void)setTransitioningController:(BCTTransitioningController *)transitioningController {
    objc_setAssociatedObject(self, @selector(transitioningController), transitioningController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BCTTransitioningController *)transitioningController {
    BCTTransitioningController *transitioningController = objc_getAssociatedObject(self, @selector(transitioningController));

    if (transitioningController == nil) {
        transitioningController = [[BCTTransitioningController alloc] init];
        [self setTransitioningController:transitioningController];
    }

    return transitioningController;
}

@end

@implementation UIViewController (Bacteria)

- (BCTControllerTransitionLocation)fromPoint {
    BCTControllerTransitionLocation fromLocation = BCTControllerTransitionLocation(point) {

        //just move from point
        self.transitioningController.presentFromPoint = point;

        return self;
    };
    return fromLocation;
}

- (BCTControllerTransitionLocation)toPoint {
    BCTControllerTransitionLocation toPoint = BCTControllerTransitionLocation(point) {

        self.transitioningController.dismissToPoint = point;

        return self;
    };
    return toPoint;
}

- (BacteriaTransitionBlock)withPresentedTransitionType {
    BacteriaTransitionBlock transitionType = BCTControllerTransitionType(type) {
        [self.transitioningController setPresentedType:type];
        return self;
    };
    return transitionType;
}

- (BacteriaTransitionBlock)withDismissedTransitionType {
    BacteriaTransitionBlock transitionType = BCTControllerTransitionType(type) {
        [self.transitioningController setDismissedType:type];
        return self;
    };
    return transitionType;
}

- (BacteriaScaleBlock)presentationScale {
    return ^UIViewController *(CGFloat initialScale, CGFloat finalScale) {

//        [[self bctTransitioningController] ]

        return self;
    };
}


- (BCTControllerTransitionSideType)presentFrom {
    BCTControllerTransitionSideType plainFrom = BCTControllerTransitionSideType(sideType) {

        //save
        [self.transitioningController setPresentedSideType:sideType];

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
        self.transitioningController.presentFromPoint = fromPoint;

        return self;
    };
    return plainFrom;
}

- (BCTControllerTransitionSideType)dismissTo {
    BCTControllerTransitionSideType plainTo = BCTControllerTransitionSideType(sideType) {

        //save
        [[self transitioningController] setDismissedSideType:sideType];

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

        self.transitioningController.dismissToPoint = toPoint;


        return self;
    };
    return plainTo;
}

- (BCTControllerTransitionTime)transite {
    BCTControllerTransitionTime ttime = BCTControllerTransitionTime(time) {
        //set delegate
        [self setTransitioningDelegate];

        self.transitioningController.duration = time;

        return self;
    };
    return ttime;
}

- (BCTControllerTransitionEmpty)reverse {
    return ^UIViewController * {

        BCTTransitionSideType dismissedSideType = self.transitioningController.dismissedSideType;
        BCTTransitionSideType presentedSideType = self.transitioningController.presentedSideType;

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
