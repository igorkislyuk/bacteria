//
//  BAControllerTransition-BlocksHeader.h
//  BAControllerTransition
//
//  Created by Igor on 20/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#ifndef BAControllerTransition_BlocksHeader_h
#define BAControllerTransition_BlocksHeader_h


//simple block wrapper
typedef UIViewController* (^BAControllerTransitionEmpty)(void);
#define BAControllerTransitionEmpty() ^UIViewController* ()

typedef UIViewController* (^BAControllerTransitionTime)(NSTimeInterval);
#define BAControllerTransitionTime(f) ^UIViewController* (NSTimeInterval f)

typedef UIViewController* (^BAControllerTransitionDistance)(CGFloat);
#define BAControllerTransitionDistance(f) ^UIViewController* (CGFloat f)

typedef UIViewController* (^BAControllerTransitionLocation)(CGPoint);
#define BAControllerTransitionLocation(f) ^UIViewController* (CGPoint f)

typedef UIViewController* (^BAControllerTransitionType)(BATransitionType type);
#define BAControllerTransitionType(t) ^UIViewController* (BATransitionType type)

#endif /* BAControllerTransition_BlocksHeader_h */
