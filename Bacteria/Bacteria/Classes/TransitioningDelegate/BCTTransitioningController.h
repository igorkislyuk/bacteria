//
//  BCTTransitioningDelegate.h
//  Bacteria
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BCTTypes.h"
#import "BCTSimpleAnimationController.h"

@protocol BCTTransitioningDelegate <NSObject>

- (NSTimeInterval)duration;

- (BOOL)presenting;

- (BCTTransitionType)transitionType;

@end

@interface BCTTransitioningController : NSObject <UIViewControllerTransitioningDelegate, BCTTransitioningDelegate>

@property (nonatomic, assign) NSTimeInterval duration;

- (void)preparePresentedFromPoint:(CGPoint)point;
- (void)prepareDismissedToPoint:(CGPoint)point;

- (void)setPresentedType:(BCTTransitionType)type;
- (void)setDismissedType:(BCTTransitionType)type;

@end
