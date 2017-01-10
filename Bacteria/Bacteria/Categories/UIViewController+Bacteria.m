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
        self.transitioningController.presentStartPoint = point;

        return self;
    };
    return fromLocation;
}

- (BCTControllerTransitionLocation)toPoint {
    BCTControllerTransitionLocation toPoint = BCTControllerTransitionLocation(point) {

        self.transitioningController.dismissEndPoint = point;

        return self;
    };
    return toPoint;
}

- (BacteriaTransitionBlock)withPresentedTransitionType {
    BacteriaTransitionBlock transitionType = BCTControllerTransitionType(type) {
        [self.transitioningController setPresentType:type];
        return self;
    };
    return transitionType;
}

- (BacteriaTransitionBlock)withDismissedTransitionType {
    BacteriaTransitionBlock transitionType = BCTControllerTransitionType(type) {
        [self.transitioningController setDismissType:type];
        return self;
    };
    return transitionType;
}

- (BacteriaScaleBlock)startScale {
    return ^UIViewController *(CGFloat x, CGFloat y) {
        [self.transitioningController setStartScale:CGSizeMake(x, y)];
        return self;
    };
}

- (BacteriaScaleBlock)endScale {
    return ^UIViewController *(CGFloat x, CGFloat y) {

        [self.transitioningController setEndScale:CGSizeMake(x, y)];

        return self;
    };
}


- (BCTControllerTransitionSideType)presentFrom {
    BCTControllerTransitionSideType plainFrom = BCTControllerTransitionSideType(sideType) {

        //save
        self.transitioningController.presentSideType = sideType;

        //get
        self.transitioningController.presentStartPoint = [self pointWithSideType:sideType];

        return self;
    };
    return plainFrom;
}

- (BCTControllerTransitionSideType)dismissTo {
    BCTControllerTransitionSideType plainTo = BCTControllerTransitionSideType(sideType) {

        //save
        self.transitioningController.dismissSideType = sideType;

        //get
        self.transitioningController.dismissEndPoint = [self pointWithSideType:sideType];


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

        BCTTransitionSideType dismissedSideType = self.transitioningController.dismissSideType;
        BCTTransitionSideType presentedSideType = self.transitioningController.presentSideType;

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

#pragma mark - Helpers

- (CGPoint)pointWithSideType:(BCTTransitionSideType)sideType {

    CGPoint point = CGPointZero;

    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);

    switch (sideType) {

        case BCTTransitionSideTypeLeft:
            point = CGPointMake(-width, 0);
            break;
        case BCTTransitionSideTypeRight:
            point = CGPointMake(width, 0);
            break;
        case BCTTransitionSideTypeTop:
            point = CGPointMake(0, -height);
            break;
        case BCTTransitionSideTypeBottom:
            point = CGPointMake(0, height);
            break;
        case BCTTransitionSideTypeTopLeftCorner:
            point = CGPointMake(-width, -height);
            break;
        case BCTTransitionSideTypeTopRightCorner:
            point = CGPointMake(width, -height);
            break;
        case BCTTransitionSideTypeBottomLeftCorner:
            point = CGPointMake(-width, height);
            break;
        case BCTTransitionSideTypeBottomRightCorner:
            point = CGPointMake(width, height);
            break;
    }

    return point;
}

@end
