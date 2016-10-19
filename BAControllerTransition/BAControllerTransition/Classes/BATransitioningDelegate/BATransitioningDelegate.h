//
//  BATransitioningDelegate.h
//  BeautifulAnimationController
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

//classes
@class BAAnimationController;

@interface BATransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) BAAnimationController *animationController;

@end
