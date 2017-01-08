//
//  BCTTransitioningDelegate.h
//  Bacteria
//
//  Created by Igor on 01/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BCTTypes.h"

@interface BCTTransitioningController : NSObject <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

//duration of transition
@property (nonatomic, assign) NSTimeInterval duration;

//points for animation process
@property (nonatomic, assign) CGPoint presentStartPoint;
@property (nonatomic, assign) CGPoint dismissEndPoint;

//parallel or cover
@property (nonatomic, assign) BCTTransitionType presentType;
@property (nonatomic, assign) BCTTransitionType dismissType;

//for "reverse" functional
@property (nonatomic, assign) BCTTransitionSideType presentSideType;
@property (nonatomic, assign) BCTTransitionSideType dismissSideType;

//scale: units
@property (nonatomic, assign) CGSize startScale;
@property (nonatomic, assign) CGSize endScale;


@end
