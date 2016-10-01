//
//  UIViewController+BAAnimationController.m
//  BeautifulAnimationController
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import <objc/runtime.h>

#import "UIViewController+BAAnimationController.h"

#import "BATransitioningDelegate.h"
#import "AnimationController.h"

@implementation UIViewController (BAAnimationController)

- (void)wrapWithTestAnimationController {
    
    self.transitioningDelegate = self.baTransitioningDelegate;
    
}



#pragma mark - Properties

- (void)setBaTransitioningDelegate:(BATransitioningDelegate *)baTransitioningDelegate {
    objc_getAssociatedObject(self, @selector(baTransitioningDelegate));
}

- (BATransitioningDelegate *)baTransitioningDelegate {
    BATransitioningDelegate* transitioningDelegate = objc_getAssociatedObject(self, @selector(baTransitioningDelegate));
    
    if (transitioningDelegate == nil) {
        transitioningDelegate = [[BATransitioningDelegate alloc] init];
    }
    
    return transitioningDelegate;
}

@end
