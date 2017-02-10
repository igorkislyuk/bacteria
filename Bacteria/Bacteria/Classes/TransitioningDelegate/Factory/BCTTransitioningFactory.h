//
// Created by Igor on 07/02/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCTTypes.h"
#import "BCTTransitioning.h"

@interface BCTTransitioningFactory : NSObject <BCTTransitioning>

//params for storing values
//duration of transition
@property (nonatomic, assign) NSTimeInterval duration;

//points for animation process
@property (nonatomic, assign) CGPoint presentStartPoint;
@property (nonatomic, assign) CGPoint dismissEndPoint;

//parallel or cover
@property (nonatomic, assign) BCTTransitionType presentType;
@property (nonatomic, assign) BCTTransitionType dismissType;

//for "reverse" functional
@property (nonatomic, assign) BCTTransitionSideType presentSideType;
@property (nonatomic, assign) BCTTransitionSideType dismissSideType;

//scale: units
@property (nonatomic, assign) CGSize startScale;
@property (nonatomic, assign) CGSize endScale;

//bool indicator for safari
@property (nonatomic, assign) BOOL safariLike;

@property (nonatomic, assign) BOOL presenting;

@end