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
 * Current version - 0.5
 */
@interface UIViewController (Bacteria)

/**
 * Required. Specify an duration in seconds, like `withDuration(0.3f)`
 */
- (BacteriaTimeBlock)withDuration;

/**
 * Specify transition type. Default transition is FlatParallel
 */
- (BacteriaTransitionBlock)presentTransition;
- (BacteriaTransitionBlock)dismissTransition;

/**
 * Specify direction for presental/dismissal controller. Note: works only for flat & flip.
 * @return controller itself
 */
- (BacteriaDirectionBlock)fromDirection;
- (BacteriaDirectionBlock)toDirection;

/**
 * Specify view for pop transition.
 * NOTE: UIView are not retained.
 * @return Block with uiview.
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



@end
