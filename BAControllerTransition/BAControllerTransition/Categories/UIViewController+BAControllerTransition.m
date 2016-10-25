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

#import "BASimpleAnimationController.h"

@interface UIViewController (BAControllerTransition_Private)

@property (nonatomic, strong) BATransitioningDelegate *baTransitioningDelegate;

@end

@implementation UIViewController (BAControllerTransition_Private)

- (void)setBATransitioningDelegate {
    if (![self.transitioningDelegate isEqual:self.baTransitioningDelegate]) {
        self.transitioningDelegate = self.baTransitioningDelegate;
    }
}

- (void)addConfiguration {
    
}

#pragma mark - Properties

- (void)setBaTransitioningDelegate:(BATransitioningDelegate *)baTransitioningDelegate {
    objc_setAssociatedObject(self, @selector(baTransitioningDelegate), baTransitioningDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BATransitioningDelegate *)baTransitioningDelegate {
    BATransitioningDelegate* transitioningDelegate = objc_getAssociatedObject(self, @selector(baTransitioningDelegate));
    
    if (transitioningDelegate == nil) {
        transitioningDelegate = [[BATransitioningDelegate alloc] init];
        [self setBaTransitioningDelegate:transitioningDelegate];
    }
    
    return transitioningDelegate;
}

@end

@implementation UIViewController (BAControllerTransition)

//main implementation here

- (BAControllerTransitionEmpty)fromRightPlain {
    BAControllerTransitionEmpty simple = BAControllerTransitionEmpty() {
        
        //just move from right side
        CGFloat right = CGRectGetWidth(self.view.frame);
        [[self baTransitioningDelegate] preparePresentedFrom:right];
        
        return self;
        
    };
    return simple;
}

//- (BAControllerTransitionTime)right {
//    
//}

- (BAControllerTransitionTime)transite {
    BAControllerTransitionTime ttime = BAControllerTransitionTime(time) {
        //set delegate
        [self setBATransitioningDelegate];
        
        [[self baTransitioningDelegate] setTime:time];
        
        return self;
    };
    return ttime;
}


#pragma mark - Test methods

- (void)presentTestAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Test message" message:@"This message from framework" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
