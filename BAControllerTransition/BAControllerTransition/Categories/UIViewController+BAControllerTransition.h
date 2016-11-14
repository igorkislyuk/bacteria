//
//  UIViewController+BAAnimationController.h
//  BeautifulAnimationController
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BATypes.h"
#import "BAControllerTransition-BlocksHeader.h"

@interface UIViewController (BAControllerTransition)

//from / to
//right and left
//plain / complex

#pragma mark - Complete section

//Current version - 0.0.1

/** Default is 0.3s */
- (BAControllerTransitionTime)transite;

//replace in one
- (BAControllerTransitionSideType)plainFrom;
- (BAControllerTransitionSideType)plainTo;

// specify an point from animation will be presented
- (BAControllerTransitionLocation)fromPoint;
- (BAControllerTransitionLocation)toPoint;

/** default behaviour is parallel */
- (BAControllerTransitionType)typeFrom;
- (BAControllerTransitionType)typeTo;

// test section
- (void)presentTestAlert;

@end

// TODOS

// todo: made corners
// todo: made autorevert for dismissed controller

// --version 0.0.2

// todo: Flip animation
// todo: revert flip?

// todo: Safari like animation
// todo: Pop from rectangle
// tood: Reveal and pop from custom shape

// todo: bounce
// todo: alerts
// todo: from bottoms
// todo: add spring
// todo: animation like in music
// todo: adjust frames for different views
// todo: https://www.raywenderlich.com/86521/how-to-make-a-view-controller-transition-animation-like-in-the-ping-app


//--- Long box

// todo: think about adjusting frames for views
// todo: cross view animation
// todo: create simple animation from corners
// todo: modal transitions with
// todo: i need good documentation after all of this
// todo: think about version and configurations - it needs to be easy to modify whole library
// todo: made test when controller deallocated - what happens with bacontroller transition objects. It's very important to...
// todo: after release at cocoapods - create develop version
// todo: clear all code & adjust headers
