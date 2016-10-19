//
//  UIViewController+BAAnimationController.m
//  BeautifulAnimationController
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import <objc/runtime.h>

#import "UIViewController+BAControllerTransition.h"

#import "BATransitioningDelegate.h"
#import "BAAnimationController.h"

@implementation UIViewController (BAControllerTransition)

- (void)wrapWithTestAnimationController {
    
    self.transitioningDelegate = self.baTransitioningDelegate;
    
}

// block callers
- (BATransitionEmpty)simpleWrap {
    BATransitionEmpty transition = BATransitionEmpty() {
        [self wrapWithTestAnimationController];
        return self;
    };
    
    return transition;
}

#pragma mark - Properties

- (void)setBaTransitioningDelegate:(BATransitioningDelegate *)baTransitioningDelegate {
    objc_setAssociatedObject(self, @selector(baTransitioningDelegate), baTransitioningDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BATransitioningDelegate *)baTransitioningDelegate {
    BATransitioningDelegate* transitioningDelegate = objc_getAssociatedObject(self, @selector(baTransitioningDelegate));
    
    if (transitioningDelegate == nil) {
        transitioningDelegate = [[BATransitioningDelegate alloc] init];
    }
    
    return transitioningDelegate;
}

#pragma mark - Private methods

- (void)presentTestAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Test message" message:@"This message from framework" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
