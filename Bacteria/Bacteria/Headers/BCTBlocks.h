//
//  BCTBlocks.h
//  Bacteria
//
//  Created by Igor on 12/02/17.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#ifndef BCTBlocks_h
#define BCTBlocks_h

#import <UIKit/UIKit.h>
#import "BCTTypes.h"

typedef UIViewController* (^BacteriaEmptyBlock)(void);
typedef UIViewController* (^BacteriaTimeBlock)(NSTimeInterval);
typedef UIViewController* (^BacteriaScaleBlock)(CGFloat, CGFloat);
typedef UIViewController* (^BacteriaLocationBlock)(CGPoint);
typedef UIViewController* (^BacteriaTransitionBlock)(BCTTransitionType);
typedef UIViewController* (^BacteriaDirectionBlock)(BCTDirectionType);
typedef UIViewController* (^BacteriaPopBlock)(CGRect rect, BCTScaleType scaleType);

#endif /* BCTBlocks_h */
