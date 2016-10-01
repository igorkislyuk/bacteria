//
//  UIViewController+BAAnimationController.h
//  BeautifulAnimationController
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BATransitioningDelegate;

@interface UIViewController (BAAnimationController)

@property (nonatomic, strong) BATransitioningDelegate *baTransitioningDelegate;

- (void)wrapWithTestAnimationController;

@end
