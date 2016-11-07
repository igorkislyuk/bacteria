//
//  UIViewController+BAAnimationController.h
//  BeautifulAnimationController
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAControllerTransition-BlocksHeader.h"

@interface UIViewController (BAControllerTransition)

//from / to
//right and left
//plain / complex

#pragma mark - Complete section
/** Default is 0.3s */
- (BAControllerTransitionTime)transite;

// specify an point
- (BAControllerTransitionLocation)fromPoint;

- (BAControllerTransitionEmpty)fromRightSide;
- (BAControllerTransitionEmpty)fromLeftSide;

- (BAControllerTransitionEmpty)fromTopSide;
- (BAControllerTransitionEmpty)fromBottomSide;

#pragma mark - Unstable


//test section
- (void)presentTestAlert;

@end

// TODOS

// todo: clear simple animation using from location
// todo: made to location
// todo: made autorevert for dismissed controller
// todo: Flip animation
// todo: Safari like animation
// todo: Pop from rectangle
// tood: Reveal and pop from custom shape

//todo: bounce
//todo: alerts
//todo: from bottoms
//todo: add spring

//tdoo: modal transitions with
//todo: i need good documentation after all of this
//todo: think about version and configurations - it needs to be easy to modify whole library
//todo: made test when controller deallocated - what happens with bacontroller transition objects. It's very important to...
//todo: after release at cocoapods - create develop version
//todo: clear all code
