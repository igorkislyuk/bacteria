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
 Current version - 0.1
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

/**
 * Scale factor, that will be applied to presented view. End scale for view for view is {1, 1}.
 * Measure in units
 */
- (BacteriaScaleBlock)presentStartScale;

/**
 * Scale factor for end view. Initial scale of that view {1, 1}
 */
- (BacteriaScaleBlock)dismissEndScale;

- (BCTControllerTransitionEmpty)safari;


@end

// TODO


// todo: safari like animation. Only from top. Separate presentation from dismissal - no customization. only present - dismiss.
/*
 ideal value - minus 17 degrees of X asix
*/

// todo: view retaining for presentation process.
// todo: reverse check.
// todo: flip animation. another type of transition along with parallel, cover.

// todo: pop from custom shape - https://www.raywenderlich.com/86521/how-to-make-a-view-controller-transition-animation-like-in-the-ping-app

// todo: review all code
// todo: replace all bct -> bacteria
// todo: readme
