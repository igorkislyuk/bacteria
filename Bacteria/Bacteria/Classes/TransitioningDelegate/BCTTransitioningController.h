//
//  BCTTransitioningDelegate.h
//  Bacteria
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BCTTypes.h"

@interface BCTTransitioningController : NSObject <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSTimeInterval duration;

@property (nonatomic, assign) CGPoint presentFromPoint;
@property (nonatomic, assign) CGPoint dismissToPoint;

@property (nonatomic) BCTTransitionSideType presentedSideType;
@property (nonatomic) BCTTransitionSideType dismissedSideType;

- (void)setPresentedType:(BCTTransitionType)type;
- (void)setDismissedType:(BCTTransitionType)type;

- (void)setStartScale:(CGSize)scale;
- (void)setEndScale:(CGSize)scale;


@end
