//
//  UIViewController+BAAnimationController.h
//  BeautifulAnimationController
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BCTTypes.h"
#import "BAControllerTransition-BlocksHeader.h"

/**
 Current version - 0.0.1
 */
@interface UIViewController (Bacteria)

/**
 Required. Specify an duration
 */
- (BAControllerTransitionTime)transite;

/**
 Prepare view controller for presental within an specified direction.
 */
- (BAControllerTransitionSideType)plainFrom;

/**
 Prepare view controller for dismissal within a specified direction.
 */
- (BAControllerTransitionSideType)plainTo;

/**
 Otherwise, you can specify a concrete point for presental/dismissal
 */
- (BAControllerTransitionLocation)fromPoint;
- (BAControllerTransitionLocation)toPoint;

/**
 Default behaviour is parallel
 */
- (BAControllerTransitionType)typeFrom;
- (BAControllerTransitionType)typeTo;



@end

// TODOS

// todo: made corners
// todo: change from and to - dismissFrom / presentTo
// todo: change example for deeper testing. M. b. try with expandable cells
// todo: made autorevert for dismissed controller
// todo: made bact renaming or bacteria

// todo: remove code duplication

// todo: add scalability

// --version 0.0.2

// todo: Flip animation
// todo: revert flip?

// todo: Safari like animation
// todo: Pop from rectangle
// todo: Reveal and pop from custom shape

// todo: bounce
// todo: alerts
// todo: from bottoms
// todo: add spring
// todo: animation like in music
// todo: adjust frames for different views
// todo: https://www.raywenderlich.com/86521/how-to-make-a-view-controller-transition-animation-like-in-the-ping-app


//--- Long box

// todo: think about adjusting frames for views
// todo: animation within a collections and navigation controller 
// todo: cross view animation
// todo: create simple animation from corners
// todo: modal transitions with
// todo: i need good documentation after all of this
// todo: think about version and configurations - it needs to be easy to modify whole library
// todo: made test when controller deallocated - what happens with bacontroller transition objects. It's very important to...
// todo: after release at cocoapods - create develop version
// todo: clear all code & adjust headers
