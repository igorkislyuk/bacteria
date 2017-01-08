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
- (BacteriaTransitionBlock)withPresentedTransitionType;
- (BacteriaTransitionBlock)withDismissedTransitionType;

- (BacteriaScaleBlock)startScale; //measure in units
- (BacteriaScaleBlock)endScale;


@end

// TODO

// todo: safari like animation.
// todo: flip animation with no scale. Only with type from where to flip
// todo: pop from custom shape

// todo: https://www.raywenderlich.com/86521/how-to-make-a-view-controller-transition-animation-like-in-the-ping-app

// todo: review all code
// todo: readme

// LONG

// todo: Segues, spring, interactivity. Animations for collections and navigations
