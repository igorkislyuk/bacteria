//
//  Types.h
//  BAControllerTransition
//
//  Created by Igor on 09/11/16.
//  Copyright (c) 2016 Igor Kislyuk. All rights reserved.
//

#ifndef BATypes_h
#define BATypes_h

#import <objc/NSObjCRuntime.h>

typedef NS_ENUM(NSUInteger, BATransitionType) {
    BATransitionTypeParallel = 0, //default
    BATransitionTypeCover = 1
};

typedef NS_ENUM(NSUInteger, BATransitionSideType) {
    BATransitionSideTypeLeft,
    BATransitionSideTypeRight,
    BATransitionSideTypeTop,
    BATransitionSideTypeBottom,

    //corners
    BATransitionSideTypeTopLeftCorner,
    BATransitionSideTypeTopRightCorner,
    BATransitionSideTypeBottomLeftCorner,
    BATransitionSideTypeBottomRightCorner
};

#endif /* BATypes_h */
