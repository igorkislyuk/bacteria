//
// Created by Igor on 12/02/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BCTTypes.h"
#import "BCTTransitioning.h"

@interface BCTPopTransitioningController : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithValueObtainer:(id <BCTTransitioning>)valueObtainer;

@property (nonatomic, readonly, weak) id<BCTTransitioning> valueObtainer;

@end