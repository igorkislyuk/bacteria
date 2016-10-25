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

@end

@interface BATransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate, BATransitioningDelegate>

@property (nonatomic, assign, readonly) NSTimeInterval duration;

@property (nonatomic, strong) BASimpleAnimationController *simpleAnimationController;

//methods
- (void)setTime:(NSTimeInterval)timeInterval;

- (void)preparePresentedFrom:(CGFloat)rightSideTrailingSpace;

@end
