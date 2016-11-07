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

//TODO: rename to instance [all but not protocol]
@protocol BATransitioningDelegate <NSObject>

- (NSTimeInterval)duration;

@end

@interface BATransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate, BATransitioningDelegate>

@property (nonatomic, assign) NSTimeInterval duration;

- (void)preparePresentedFromPoint:(CGPoint)point;

@end
