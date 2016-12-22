//
//  BATransitioningDelegate.h
//  BeautifulAnimationController
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BCTTypes.h"

//headers
#import <BASimpleAnimationController.h>

@protocol BATransitioningDelegate <NSObject>

- (NSTimeInterval)duration;

- (BOOL)presenting;

- (BATransitionType)transitionType;

@end

@interface BATransitioningController : NSObject <UIViewControllerTransitioningDelegate, BATransitioningDelegate>

@property (nonatomic, assign) NSTimeInterval duration;

- (void)preparePresentedFromPoint:(CGPoint)point;
- (void)prepareDismissedToPoint:(CGPoint)point;

- (void)setPresentedType:(BATransitionType)type;
- (void)setDismissedType:(BATransitionType)type;

@end
