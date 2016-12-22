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

@property(nonatomic, strong) BCTTransitioningController *baTransitioningDelegate;

@end

@implementation UIViewController (Bacteria_Private)

- (void)setBATransitioningDelegate {
    if (![self.transitioningDelegate isEqual:self.baTransitioningDelegate]) {
        self.transitioningDelegate = self.baTransitioningDelegate;
    }
}

- (void)addConfiguration {

}

#pragma mark - Properties

- (void)setBaTransitioningDelegate:(BCTTransitioningController *)baTransitioningDelegate {
    objc_setAssociatedObject(self, @selector(baTransitioningDelegate), baTransitioningDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BCTTransitioningController *)baTransitioningDelegate {
    BCTTransitioningController *transitioningDelegate = objc_getAssociatedObject(self, @selector(baTransitioningDelegate));

    if (transitioningDelegate == nil) {
        transitioningDelegate = [[BCTTransitioningController alloc] init];
        [self setBaTransitioningDelegate:transitioningDelegate];
    }

    return transitioningDelegate;
}

@end

@implementation UIViewController (Bacteria)

//main implementation here

//core functionality
- (BCTControllerTransitionLocation)fromPoint {
    BCTControllerTransitionLocation fromLocation = BCTControllerTransitionLocation(point) {

        //just move from point
        [[self baTransitioningDelegate] preparePresentedFromPoint:point];

        return self;
    };
    return fromLocation;
}

- (BCTControllerTransitionLocation)toPoint {
    BCTControllerTransitionLocation toPoint = BCTControllerTransitionLocation(point) {

        [[self baTransitioningDelegate] prepareDismissedToPoint:point];

        return self;
    };
    return toPoint;
}

- (BCTControllerTransitionType)typeFrom {
    BCTControllerTransitionType transitionType = BCTControllerTransitionType(type) {
        [[self baTransitioningDelegate] setPresentedType:type];
        return self;
    };
    return transitionType;
}

- (BCTControllerTransitionType)typeTo {
    BCTControllerTransitionType transitionType = BCTControllerTransitionType(type) {
        [[self baTransitioningDelegate] setDismissedType:type];
        return self;
    };
    return transitionType;
}


//fine from transitions
- (BCTControllerTransitionSideType)presentFrom {
    BCTControllerTransitionSideType plainFrom = BCTControllerTransitionSideType(sideType) {

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

        [[self baTransitioningDelegate] preparePresentedFromPoint:fromPoint];

        return self;
    };
    return plainFrom;
}

//fine to transitions
- (BCTControllerTransitionSideType)dismissTo {
    BCTControllerTransitionSideType plainTo = BCTControllerTransitionSideType(sideType) {

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

        [[self baTransitioningDelegate] prepareDismissedToPoint:toPoint];


        return self;
    };
    return plainTo;
}


- (BCTControllerTransitionTime)transite {
    BCTControllerTransitionTime ttime = BCTControllerTransitionTime(time) {
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
