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

@property (nonatomic, weak) id <BATransitioningDelegate> transitioningDelegate;

@property (nonatomic, assign) CGPoint fromPoint;
@property (nonatomic, assign) CGPoint toPoint;

@end
