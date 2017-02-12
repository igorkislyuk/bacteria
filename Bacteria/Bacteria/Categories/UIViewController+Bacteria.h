//
//  UIViewController+Bacteria.h
//  Bacteria
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BCTTypes.h"
#import "BCTBlocks.h"

/**
 * Current version - 0.4
 */

@interface UIViewController (Bacteria)

/**
 * Required. Specify an duration, like `withDuration(0.3f)`
 * @return controller itself
 */
- (BacteriaTimeBlock)withDuration;

/**
 * Specify transition type. Default transition is FlatParallel
 * @return controller itself
 */
- (BacteriaTransitionBlock)presentTransition;
- (BacteriaTransitionBlock)dismissTransition;

/**
 * Specify direction for presental/dismissal controller. Note: works only for flap & flip.
 * @return controller itself
 */
- (BacteriaDirectionBlock)fromDirection;
- (BacteriaDirectionBlock)toDirection;

/**
 * Specify shape for pop transition
 * @return controller itself
 */
- (BacteriaPopBlock)popFrom;
- (BacteriaPopBlock)popTo;

/**
 * Initial/Final scale factor for presented/dismissed view. End/Initial scale of that view is { 1, 1 }.
 * Only for Flat.
 * Measures in units.
 * Default to { 1, 1 }
 * @return controller itself
 */
- (BacteriaScaleBlock)fromScale;
- (BacteriaScaleBlock)toScale;

/**
 * Otherwise, you can specify a concrete point for presental/dismissal.
 * @return controller itself
 */
- (BacteriaLocationBlock)fromPoint;
- (BacteriaLocationBlock)toPoint;

/**
 * This transition will simulate page-switching in Safari with portrait mode. Block others transitions.
 * @return controller itself
 */
//- (BacteriaEmptyBlock)withSafariAnimation;



@end

// TODO

// todo: pop from custom shape

// todo: add functionality to retain view within container view. Tip: you should use snapshot, not `addSubview:`
// todo: add for each method method that will reset safari like value
// todo: reverse

// todo: think about custom points for presenting & dismissing.
// Possibly it useless. Will you present controller from center of another?

// todo: check reverse function for all transitions
// todo: refactor whole project
// todo: remove logs
// todo: rename: bct -> bacteria
// todo: made good readme

// fixme: think about refactor simple controller to chain model with keyframes...