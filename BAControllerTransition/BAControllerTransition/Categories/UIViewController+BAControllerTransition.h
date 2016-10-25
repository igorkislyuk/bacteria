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

#pragma mark - Complete section
- (BAControllerTransitionEmpty)fromRightPlain;


- (BAControllerTransitionEmpty)fromRightDefault;
- (BAControllerTransitionDistance)right;

/**
 * Default is 0.3s
 */
- (BAControllerTransitionTime)transite;

- (void)presentTestAlert;

@end
