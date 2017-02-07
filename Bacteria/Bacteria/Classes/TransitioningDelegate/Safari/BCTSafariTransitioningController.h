//
// Created by Igor on 07/02/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BCTTransitioning;

@interface BCTSafariTransitioningController : NSObject <UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithValueObtainer:(id <BCTTransitioning>)valueObtainer;

@property (nonatomic, readonly, weak) id<BCTTransitioning> valueObtainer;

@end