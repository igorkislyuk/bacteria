//
//  UIViewController+Bacteria.m
//  Bacteria
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import <objc/runtime.h>

#import "UIViewController+Bacteria.h"

#import "BCTTransitioningFactory.h"

@interface UIViewController (Bacteria_Private)

@property(nonatomic, strong) BCTTransitioningFactory *transitioningFactory;

@end

@implementation UIViewController (Bacteria_Private)

#pragma mark - Properties

- (BCTTransitioningFactory *)transitioningFactory {
    BCTTransitioningFactory *factory = objc_getAssociatedObject(self, @selector(transitioningFactory));

    if (factory == nil) {
        factory = [[BCTTransitioningFactory alloc] init];
        [self setTransitioningFactory:factory];
    }

    return factory;
}

- (void)setTransitioningFactory:(BCTTransitioningFactory *)transitioningFactory {
    objc_setAssociatedObject(self, @selector(transitioningFactory), transitioningFactory, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end

@implementation UIViewController (Bacteria)

- (BCTControllerTransitionLocation)fromPoint {
    BCTControllerTransitionLocation fromLocation = BCTControllerTransitionLocation(point) {

        //just move from point
        self.transitioningFactory.presentStartPoint = point;

        return self;
    };
    return fromLocation;
}

- (BCTControllerTransitionLocation)toPoint {
    BCTControllerTransitionLocation toPoint = BCTControllerTransitionLocation(point) {

        self.transitioningFactory.dismissEndPoint = point;

        return self;
    };
    return toPoint;
}

- (BacteriaTransitionBlock)withPresentedTransitionType {
    BacteriaTransitionBlock transitionType = BCTControllerTransitionType(type) {
        self.transitioningFactory.presentType = type;
        return self;
    };
    return transitionType;
}

- (BacteriaTransitionBlock)withDismissedTransitionType {
    BacteriaTransitionBlock transitionType = BCTControllerTransitionType(type) {
        self.transitioningFactory.dismissType = type;
        return self;
    };
    return transitionType;
}

- (BacteriaScaleBlock)presentStartScale {
    BacteriaScaleBlock scaleBlock = BacteriaScaleBlock(x, y) {
        self.transitioningFactory.startScale = CGSizeMake(x, y);
        return self;
    };
    return scaleBlock;
}

- (BacteriaScaleBlock)dismissEndScale {
    BacteriaScaleBlock scaleBlock = BacteriaScaleBlock(x, y) {

        self.transitioningFactory.endScale = CGSizeMake(x, y);

        return self;
    };
    return scaleBlock;
}

- (BCTControllerTransitionEmpty)safari {
    return ^UIViewController * {

        //set another delegate
        self.transitioningFactory.safariLike = YES;

        return self;
    };
}


- (BCTControllerTransitionSideType)presentFrom {
    BCTControllerTransitionSideType plainFrom = BCTControllerTransitionSideType(sideType) {

        //save
        self.transitioningFactory.presentSideType = sideType;

        //get
        self.transitioningFactory.presentStartPoint = [self pointWithSideType:sideType];

        return self;
    };
    return plainFrom;
}

- (BCTControllerTransitionSideType)dismissTo {
    BCTControllerTransitionSideType plainTo = BCTControllerTransitionSideType(sideType) {

        //save
        self.transitioningFactory.dismissSideType = sideType;

        //get
        self.transitioningFactory.dismissEndPoint = [self pointWithSideType:sideType];


        return self;
    };
    return plainTo;
}

- (BCTControllerTransitionTime)transite {
    BCTControllerTransitionTime ttime = BCTControllerTransitionTime(time) {

        self.transitioningFactory.duration = time;
        
        self.transitioningDelegate = [self.transitioningFactory transitioningDelegate];

        return self;
    };
    return ttime;
}

- (BCTControllerTransitionEmpty)reverse {
    return ^UIViewController * {

        BCTTransitionSideType dismissedSideType = self.transitioningFactory.dismissSideType;
        BCTTransitionSideType presentedSideType = self.transitioningFactory.presentSideType;

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
