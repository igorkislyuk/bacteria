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

typedef UIViewController* (^BCTControllerTransitionDistance)(CGFloat);
#define BCTControllerTransitionDistance(f) ^UIViewController* (CGFloat f)

typedef UIViewController* (^BCTControllerTransitionLocation)(CGPoint);
#define BCTControllerTransitionLocation(f) ^UIViewController* (CGPoint f)

typedef UIViewController* (^BCTControllerTransitionType)(BCTTransitionType type);
#define BCTControllerTransitionType(t) ^UIViewController* (BCTTransitionType type)

typedef UIViewController* (^BCTControllerTransitionSideType)(BCTTransitionSideType sideType);
#define BCTControllerTransitionSideType(t) ^UIViewController* (BCTTransitionSideType sideType)

#endif /* BCT_BlocksHeader_h */
