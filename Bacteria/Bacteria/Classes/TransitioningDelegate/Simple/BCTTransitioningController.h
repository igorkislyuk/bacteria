//
//  BCTTransitioningDelegate.h
//  Bacteria
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BCTTypes.h"
#import "BCTTransitioning.h"

@interface BCTTransitioningController : NSObject <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithValueObtainer:(id <BCTTransitioning>)valueObtainer;
@property (nonatomic, readonly, weak) id<BCTTransitioning> valueObtainer;

@end
