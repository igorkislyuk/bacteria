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
 * Current version - 0.3
 */

@interface UIViewController (Bacteria)

/**
 * Required. Specify an duration, like `transite(0.3f)`
 * @return controller itself
 */
- (BCTControllerTransitionTime)transite;

/**
 * Prepare view controller for presental within an specified direction.
 * @return controller itself
 */
- (BCTControllerTransitionSideType)presentFrom;

/**
 * Prepare view controller for dismissal within a specified direction.
 * @return controller itself
 */
- (BCTControllerTransitionSideType)dismissTo;

/**
 * Set reverse for another action. If you set `presentFrom()`, than reverse function will add `dismissTo()` silently, and vice versa.
 * @return controller itself
 */
- (BCTControllerTransitionEmpty)reverse;

/**
 * Otherwise, you can specify a concrete point for presental/dismissal.
 * @return controller itself
 */
- (BCTControllerTransitionLocation)fromPoint;
- (BCTControllerTransitionLocation)toPoint;

/**
 * Default behaviour is parallel
 * @return controller itself
 */
- (BacteriaTransitionBlock)withPresentedTransitionType;
- (BacteriaTransitionBlock)withDismissedTransitionType;

/**
 * Initial scale factor for presented view. End scale for view for view is {1, 1}.
 * Measures in units. Default to { 1, 1}
 * @return controller itself
 */
- (BacteriaScaleBlock)presentStartScale;

/**
 * Final scale factor for dismissed view. Initial scale of that view { 1, 1 }
 * Measures in units. Default to { 1, 1 }
 * @return controller itself
 */
- (BacteriaScaleBlock)dismissEndScale;

/**
 * This transition will simulate page-switching in Safari with portrait mode. Block others transitions.
 * @return controller itself
 */
- (BCTControllerTransitionEmpty)safari;

@end

// TODO

// todo: pop from custom shape - https://www.raywenderlich.com/86521/how-to-make-a-view-controller-transition-animation-like-in-the-ping-app

// todo: add functionality to retain view within container view. Tip: you should use snapshot, not `addSubview:`
// todo: add for each method method that will reset safari like value

// todo: think about custom points for presenting & dismissing.
// Possibly it useless. Will you present controller from center of another?

// todo: check reverse function for all transitions
// todo: refactor whole project
// todo: rename: bct -> bacteria
// todo: made good readme

// fixme: think about refactor simple controller to chain model with keyframes...