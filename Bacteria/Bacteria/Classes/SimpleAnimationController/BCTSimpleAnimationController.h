//
//  BCTSimpleAnimationController.h
//  Bacteria
//
//  Created by Igor on 24/09/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BCTTransitioningDelegate;

@interface BCTSimpleAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, weak) id <BCTTransitioningDelegate> transitioningDelegate;

//Original point - initial location

/**Point for presented controller*/
@property (nonatomic, assign) CGPoint fromPoint;

/**Point for dismissed controller*/
@property (nonatomic, assign) CGPoint toPoint;

@end
