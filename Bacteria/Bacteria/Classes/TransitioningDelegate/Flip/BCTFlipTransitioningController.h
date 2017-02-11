//
// Created by Igor on 10/02/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BCTTransitioning;

@interface BCTFlipTransitioningController : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithValueObtainer:(id <BCTTransitioning>)valueObtainer;

@property (nonatomic, readonly, weak) id<BCTTransitioning> valueObtainer;

@end