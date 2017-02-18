//
// Created by Igor on 05/01/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCTBasicViewPerformer : NSObject

@property (nonatomic, strong, readonly) UIView *presentedView;
@property (nonatomic, strong, readonly) UIView *dismissedView;

@property (nonatomic, assign, readonly) CGAffineTransform presentedTransform, dismissedTransform;

@property (nonatomic, assign) CGPoint offsetPoint;

/**
 * Means initial scale for presented view
 */
@property (nonatomic, assign) CGSize startScale; //default to 1

/**
 * It's final scale for dismissed view
 */
@property (nonatomic, assign) CGSize endScale; //default to 1

- (instancetype)initWithPresentedView:(UIView *)presentedView dismissedView:(UIView *)dismissedView;

@end
