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
- (BAControllerTransitionEmpty)fromRightPlain;
- (BAControllerTransitionEmpty)fromLeftPlain;

/** Default is 0.3s */
- (BAControllerTransitionTime)transite;

#pragma mark - Unstable

- (BAControllerTransitionEmpty)fromTopPlain;
- (BAControllerTransitionEmpty)fromBottomPlain;
- (BAControllerTransitionLocation)fromLocation;

- (void)presentTestAlert;

@end

// TODOS

// todo: clear simple animation using from location
// todo: made to location
// todo: made autorevert for dismissed controller
