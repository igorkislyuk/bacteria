//
//  UIViewController+BAAnimationController.h
//  BeautifulAnimationController
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BAControllerTransition-BlocksHeader.h"

@class BATransitioningDelegate;

@interface UIViewController (BAControllerTransition)

//@property (nonatomic, strong) BATransitioningDelegate *baTransitioningDelegate;

- (void)wrapWithTestAnimationController;

- (BATransitionEmpty)simpleWrap;

- (void)presentTestAlert;

@end
