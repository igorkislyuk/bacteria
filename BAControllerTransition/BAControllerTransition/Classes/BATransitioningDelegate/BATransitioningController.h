//
//  BATransitioningDelegate.h
//  BeautifulAnimationController
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

//headers
#import <BASimpleAnimationController.h>

@protocol BATransitioningDelegate <NSObject>

- (NSTimeInterval)duration;

- (BOOL)presenting;

@end

@interface BATransitioningController : NSObject <UIViewControllerTransitioningDelegate, BATransitioningDelegate>

@property (nonatomic, assign) NSTimeInterval duration;

- (void)preparePresentedFromPoint:(CGPoint)point;
- (void)prepareDismissedToPoint:(CGPoint)point;

@end
