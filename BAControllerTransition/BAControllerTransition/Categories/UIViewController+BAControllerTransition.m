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

@property(nonatomic, strong) BATransitioningController *baTransitioningDelegate;

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
    BATransitioningController *transitioningDelegate = objc_getAssociatedObject(self, @selector(baTransitioningDelegate));

    if (transitioningDelegate == nil) {
        transitioningDelegate = [[BATransitioningController alloc] init];
        [self setBaTransitioningDelegate:transitioningDelegate];
    }

    return transitioningDelegate;
}

@end

@implementation UIViewController (BAControllerTransition)

//main implementation here

//core functionality
- (BAControllerTransitionLocation)fromPoint {
    BAControllerTransitionLocation fromLocation = BAControllerTransitionLocation(point) {

        //just move from point
        [[self baTransitioningDelegate] preparePresentedFromPoint:point];

        return self;
    };
    return fromLocation;
}

- (BAControllerTransitionLocation)toPoint {
    BAControllerTransitionLocation toPoint = BAControllerTransitionLocation(point) {

        [[self baTransitioningDelegate] prepareDismissedToPoint:point];

        return self;
    };
    return toPoint;
}

- (BAControllerTransitionType)typeFrom {
    BAControllerTransitionType transitionType = BAControllerTransitionType(type) {
        [[self baTransitioningDelegate] setPresentedType:type];
        return self;
    };
    return transitionType;
}

- (BAControllerTransitionType)typeTo {
    BAControllerTransitionType transitionType = BAControllerTransitionType(type) {
        [[self baTransitioningDelegate] setDismissedType:type];
        return self;
    };
    return transitionType;
}


//fine from transitions
- (BAControllerTransitionSideType)plainFrom {
    BAControllerTransitionSideType plainFrom = BAControllerTransitionSideType(sideType) {

        CGPoint fromPoint = CGPointZero;

        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat height = CGRectGetHeight(self.view.bounds);

        switch (sideType) {
            case BATransitionSideTypeLeft:
                fromPoint = CGPointMake(-width, 0);
                break;
            case BATransitionSideTypeRight:
                fromPoint = CGPointMake(width, 0);
                break;
            case BATransitionSideTypeTop:
                fromPoint = CGPointMake(0, -height);
                break;
            case BATransitionSideTypeBottom:
                fromPoint = CGPointMake(0, height);
                break;
            case BATransitionSideTypeTopLeftCorner:
                fromPoint = CGPointMake(-width, -height);
                break;
            case BATransitionSideTypeTopRightCorner:
                fromPoint = CGPointMake(width, -height);
                break;
            case BATransitionSideTypeBottomLeftCorner:
                fromPoint = CGPointMake(-width, height);
                break;
            case BATransitionSideTypeBottomRightCorner:
                fromPoint = CGPointMake(width, height);
                break;
        }

        [[self baTransitioningDelegate] preparePresentedFromPoint:fromPoint];

        return self;
    };
    return plainFrom;
}

//fine to transitions
- (BAControllerTransitionSideType)plainTo {
    BAControllerTransitionSideType plainTo = BAControllerTransitionSideType(sideType) {

        CGPoint toPoint = CGPointZero;

        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat height = CGRectGetHeight(self.view.bounds);

        switch (sideType) {

            case BATransitionSideTypeLeft:
                toPoint = CGPointMake(-width, 0);
                break;
            case BATransitionSideTypeRight:
                toPoint = CGPointMake(width, 0);
                break;
            case BATransitionSideTypeTop:
                toPoint = CGPointMake(0, -height);
                break;
            case BATransitionSideTypeBottom:
                toPoint = CGPointMake(0, height);
                break;
            case BATransitionSideTypeTopLeftCorner:
                toPoint = CGPointMake(-width, -height);
                break;
            case BATransitionSideTypeTopRightCorner:
                toPoint = CGPointMake(width, -height);
                break;
            case BATransitionSideTypeBottomLeftCorner:
                toPoint = CGPointMake(-width, height);
                break;
            case BATransitionSideTypeBottomRightCorner:
                toPoint = CGPointMake(width, height);
                break;
        }

        [[self baTransitioningDelegate] prepareDismissedToPoint:toPoint];


        return self;
    };
    return plainTo;
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
