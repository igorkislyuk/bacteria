//
//  UIViewController+Bacteria.h
//  Bacteria
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BCTTypes.h"
#import "BCT-BlocksHeader.h"

/**
 Current version - 0.0.1
 */
@interface UIViewController (Bacteria)

/**
 Required. Specify an duration
 */
- (BCTControllerTransitionTime)transite;

/**
 Prepare view controller for presental within an specified direction.
 */
- (BCTControllerTransitionSideType)presentFrom;

/**
 Prepare view controller for dismissal within a specified direction.
 */
- (BCTControllerTransitionSideType)dismissTo;

/**
 * Set reverse for another action. If you set present from - reverse will add dismiss, and vice versa.
 */
- (BCTControllerTransitionEmpty)reverse;

/**
 Otherwise, you can specify a concrete point for presental/dismissal
 */
- (BCTControllerTransitionLocation)fromPoint;
- (BCTControllerTransitionLocation)toPoint;

/**
 Default behaviour is parallel
 */
- (BCTControllerTransitionType)typeFrom;
- (BCTControllerTransitionType)typeTo;



@end

// TODO

// todo: change example for deeper testing. M. b. try with expandable cells

// todo: add scale
// todo: Flip animation

// todo: Safari like animation
// todo: Pop from rectangle
// todo: Reveal and pop from custom shape

// todo: bounce
// todo: alerts
// todo: from bottoms
// todo: add spring
// todo: animation like in music
// todo: https://www.raywenderlich.com/86521/how-to-make-a-view-controller-transition-animation-like-in-the-ping-app

// todo: think about adjusting frames for views
// todo: animation within a collections and navigation controller
// todo: cross view animation
// todo: modal transitions with

// todo: made test when controller deallocated - what happens with bacteria controller transition objects. It's very important to...

// todo: remove code duplication
// todo: code cleanup & adjust headers

// todo: documentation
// todo: release
