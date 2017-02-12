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

@property(nonatomic, strong) id <BCTTransitioning> transitioningFactory;

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

#pragma mark - Helpers

- (CGPoint)pointWithSideType:(BCTDirectionType)sideType {

    CGPoint point = CGPointZero;

    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);

    switch (sideType) {

        case BCTDirectionLeft:
            point = CGPointMake(-width, 0);
            break;
        case BCTDirectionRight:
            point = CGPointMake(width, 0);
            break;
        case BCTDirectionTop:
            point = CGPointMake(0, -height);
            break;
        case BCTDirectionBottom:
            point = CGPointMake(0, height);
            break;
        case BCTDirectionTopLeft:
            point = CGPointMake(-width, -height);
            break;
        case BCTDirectionTopRight:
            point = CGPointMake(width, -height);
            break;
        case BCTDirectionBottomLeft:
            point = CGPointMake(-width, height);
            break;
        case BCTDirectionBottomRight:
            point = CGPointMake(width, height);
            break;
    }

    return point;
}

- (void)adjustTransitionTypes {
    if (self.transitioningFactory.presentTransitionType && self.transitioningFactory.dismissTransitionType) {
        //fine
        return;
        
    } else if (self.transitioningFactory.presentTransitionType && !self.transitioningFactory.dismissTransitionType) {
        //no dismiss transition type
        self.dismissTransition(self.transitioningFactory.presentTransitionType);

    } else if (self.transitioningFactory.dismissTransitionType && !self.transitioningFactory.presentTransitionType) {
        // no present type
        self.dismissTransition(self.transitioningFactory.presentTransitionType);

    } else {
        //both are empty
        self.presentTransition(BCTTransitionFlatParallel).dismissTransition(BCTTransitionFlatParallel);
    }
}

- (void)adjustDirectionTypes {
    if (self.transitioningFactory.presentDirectionType && self.transitioningFactory.dismissDirectionType) {
        //fine
        return;
    } else if (self.transitioningFactory.presentDirectionType && !self.transitioningFactory.dismissDirectionType) {

        self.toDirection([self reverseDirection:self.transitioningFactory.presentDirectionType]);
    } else if (self.transitioningFactory.dismissDirectionType && !self.transitioningFactory.presentDirectionType) {
        
        self.fromDirection([self reverseDirection:self.transitioningFactory.dismissDirectionType]);
    } else {
        self.fromDirection(BCTDirectionTop).toDirection(BCTDirectionTop);
    }
}

- (BCTDirectionType)reverseDirection:(BCTDirectionType)type {
    switch (type) {

        case BCTDirectionTop:
            return BCTDirectionBottom;

        case BCTDirectionLeft:
            return BCTDirectionRight;

        case BCTDirectionBottom:
            return BCTDirectionTop;

        case BCTDirectionRight:
            return BCTDirectionLeft;

        case BCTDirectionTopLeft:
            return BCTDirectionBottomRight;

        case BCTDirectionBottomLeft:
            return BCTDirectionTopRight;

        case BCTDirectionBottomRight:
            return BCTDirectionTopLeft;

        case BCTDirectionTopRight:
            return BCTDirectionBottomLeft;
    }
}

#pragma mark - Implementation

- (BacteriaTimeBlock)withDuration {
    return ^UIViewController *(NSTimeInterval time) {

        [self adjustTransitionTypes];
        [self adjustDirectionTypes];

        self.transitioningFactory.duration = time;
        self.transitioningDelegate = self.transitioningFactory;
        return self;
    };
}

- (BacteriaTransitionBlock)presentTransition {
    return ^UIViewController *(BCTTransitionType type) {
        self.transitioningFactory.presentTransitionType = type;
        return self;
    };
}

- (BacteriaTransitionBlock)dismissTransition {
    return ^UIViewController *(BCTTransitionType type) {
        self.transitioningFactory.dismissTransitionType = type;
        return self;
    };
}

- (BacteriaDirectionBlock)fromDirection {
    return ^UIViewController *(BCTDirectionType type) {
        self.transitioningFactory.presentDirectionType = type;
        self.transitioningFactory.presentStartPoint = [self pointWithSideType:type];
        return self;
    };
}

- (BacteriaDirectionBlock)toDirection {
    return ^UIViewController *(BCTDirectionType type) {
        self.transitioningFactory.dismissDirectionType = type;
        self.transitioningFactory.dismissEndPoint = [self pointWithSideType:type];
        return self;
    };
}

- (BacteriaPopBlock)popFrom {
    return ^UIViewController *(CGRect rect, BCTScaleType scaleType) {
        return nil;
    };
}

- (BacteriaPopBlock)popTo {
    return ^UIViewController *(CGRect rect, BCTScaleType scaleType) {
        return nil;
    };
}

- (BacteriaScaleBlock)fromScale {
    return ^UIViewController *(CGFloat x, CGFloat y) {
        self.transitioningFactory.startScale = CGSizeMake(x, y);
        return self;
    };
}

- (BacteriaScaleBlock)toScale {
    return ^UIViewController *(CGFloat x, CGFloat y) {
        self.transitioningFactory.endScale = CGSizeMake(x, y);
        return self;
    };
}

- (BacteriaLocationBlock)fromPoint {
    return ^UIViewController *(CGPoint point) {
        self.transitioningFactory.presentStartPoint = point;
        return self;
    };
}

- (BacteriaLocationBlock)toPoint {
    return ^UIViewController *(CGPoint point) {
        self.transitioningFactory.dismissEndPoint = point;
        return self;
    };
}


@end
