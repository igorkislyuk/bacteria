//
//  UIViewController+BAAnimationController.h
//  BeautifulAnimationController
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Types.h"
#import "BAControllerTransition-BlocksHeader.h"

@interface UIViewController (BAControllerTransition)

//from / to
//right and left
//plain / complex

#pragma mark - Complete section
/** Default is 0.3s */
- (BAControllerTransitionTime)transite;

// specify an point from animation will be presented
- (BAControllerTransitionLocation)fromPoint;
- (BAControllerTransitionLocation)toPoint;

/** default behaviour is parallel */
- (BAControllerTransitionType)typeFrom;
- (BAControllerTransitionType)typeTo;

- (BAControllerTransitionEmpty)fromRightSide;
- (BAControllerTransitionEmpty)fromLeftSide;
- (BAControllerTransitionEmpty)fromTopSide;
- (BAControllerTransitionEmpty)fromBottomSide;

- (BAControllerTransitionEmpty)toRightSide;
- (BAControllerTransitionEmpty)toLeftSide;
- (BAControllerTransitionEmpty)toTopSide;
- (BAControllerTransitionEmpty)toBottomSide;


// test section
- (void)presentTestAlert;

@end

// TODOS

// --version 0.0.1

// todo: made to location
// todo: made autorevert for dismissed controller
// todo: add two types: cover || pushing

// --version 0.0.2

// todo: remove few methods. Create and enum for all sides.

// todo: Flip animation
// todo: revert flip?

// todo: Safari like animation
// todo: Pop from rectangle
// tood: Reveal and pop from custom shape

// todo: bounce
// todo: alerts
// todo: from bottoms
// todo: add spring


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
