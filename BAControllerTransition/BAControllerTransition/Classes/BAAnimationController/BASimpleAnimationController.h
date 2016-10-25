//
//  AnimationController.h
//  BeautifulAnimationController
//
//  Created by Igor on 24/09/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BATransitioningDelegate;

@interface BASimpleAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

// todo: create an protocol
@property (nonatomic, weak) id <BATransitioningDelegate> transitioningDelegate;

- (void)setDistanceFromRight:(CGFloat)right;

@end
