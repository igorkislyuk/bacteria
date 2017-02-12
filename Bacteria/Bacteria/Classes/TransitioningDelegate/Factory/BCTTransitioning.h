//
// Created by Igor on 07/02/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCTTypes.h"

#define DEGREES_TO_RADIANS(degrees) (CGFloat)((M_PI * degrees)/180.0f)

/**
 * Describe inner state for determine which transition controller should be returned.
 */
typedef NS_ENUM(NSUInteger, BCTInnerTransitionType) {
    BCTInnerTransitionTypeSimple = 0,
    BCTInnerTransitionTypeFlip = 1,
    BCTInnerTransitionTypeSafari = 2,
    BCTInnerTransitionTypePop = 3
};

@protocol BCTTransitioning <UIViewControllerTransitioningDelegate>

#pragma mark - Common

//duration of transition
@property (nonatomic, assign) NSTimeInterval duration;

@property (nonatomic, assign) BOOL presenting;

#pragma mark - Simple

//parallel or cover
@property (nonatomic, assign) BCTTransitionType presentType;
@property (nonatomic, assign) BCTTransitionType dismissType;

//for "reverse" functional
@property (nonatomic, assign) BCTTransitionSideType presentSideType;
@property (nonatomic, assign) BCTTransitionSideType dismissSideType;

//scale: units
@property (nonatomic, assign) CGSize startScale;
@property (nonatomic, assign) CGSize endScale;

#pragma mark - To be deleted

//points for animation process
@property (nonatomic, assign) CGPoint presentStartPoint;
@property (nonatomic, assign) CGPoint dismissEndPoint;

#pragma mark - Inner

@property (nonatomic, assign) BCTInnerTransitionType innerPresentType;
@property (nonatomic, assign) BCTInnerTransitionType innerDismissType;

@end