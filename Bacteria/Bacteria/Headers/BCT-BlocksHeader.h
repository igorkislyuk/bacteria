//
//  BCT-BlocksHeader.h
//  Bacteria
//
//  Created by Igor on 20/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#ifndef BCT_BlocksHeader_h
#define BCT_BlocksHeader_h

//simple block wrapper
typedef UIViewController* (^BCTControllerTransitionEmpty)(void);
#define BCTControllerTransitionEmpty() ^UIViewController* ()

typedef UIViewController* (^BCTControllerTransitionTime)(NSTimeInterval);
#define BCTControllerTransitionTime(f) ^UIViewController* (NSTimeInterval f)

typedef UIViewController* (^BacteriaScaleBlock)(CGFloat, CGFloat);
#define BacteriaScaleBlock(value1, value2) ^UIViewController* (CGFloat value1, CGFloat value2)

typedef UIViewController* (^BCTControllerTransitionLocation)(CGPoint);
#define BCTControllerTransitionLocation(f) ^UIViewController* (CGPoint f)

typedef UIViewController* (^BacteriaTransitionBlock)(BCTTransitionType type);
#define BCTControllerTransitionType(t) ^UIViewController* (BCTTransitionType type)

typedef UIViewController* (^BCTControllerTransitionSideType)(BCTTransitionSideType sideType);
#define BCTControllerTransitionSideType(t) ^UIViewController* (BCTTransitionSideType sideType)

//shape and scale type
typedef UIViewController *(^BacteriaPathBlock)(CGRect rect, BCTScaleType scaleType);

#endif /* BCT_BlocksHeader_h */
