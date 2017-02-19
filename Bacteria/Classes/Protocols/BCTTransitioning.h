//
// Created by Igor on 07/02/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCTTypes.h"

#define DEGREES_TO_RADIANS(degrees) (CGFloat)((M_PI * degrees)/180.0f)

@protocol BCTTransitioning <UIViewControllerTransitioningDelegate>

//duration of transition
@property (nonatomic, assign) NSTimeInterval duration;

@property (nonatomic, assign) BOOL presenting;

//parallel or cover
@property (nonatomic, assign) BCTTransitionType presentTransitionType;
@property (nonatomic, assign) BCTTransitionType dismissTransitionType;

//for "reverse" functional
@property (nonatomic, assign) BCTDirectionType presentDirectionType;
@property (nonatomic, assign) BCTDirectionType dismissDirectionType;

//scale: units
@property (nonatomic, assign) CGSize startScale;
@property (nonatomic, assign) CGSize endScale;

//points for animation process
@property (nonatomic, assign) CGPoint presentStartPoint;
@property (nonatomic, assign) CGPoint dismissEndPoint;

//for pop animation
@property(nonatomic, weak) UIView *startPopView;
@property(nonatomic, weak) UIView *endPopView;

@end