//
//  BCTTypes.h
//  Bacteria
//
//  Created by Igor on 09/11/16.
//  Copyright (c) 2016 Igor Kislyuk. All rights reserved.
//

#ifndef BCTTypes_h
#define BCTTypes_h

#import <objc/NSObjCRuntime.h>

typedef NS_ENUM(NSUInteger, BCTTransitionType) {
    BCTTransitionTypeParallel = 0, //default
    BCTTransitionTypeCover = 1,
    BCTTransitionTypeFlip = 2
};

typedef NS_ENUM(NSUInteger, BCTTransitionSideType) {
    BCTTransitionSideTypeTop = 0,
    BCTTransitionSideTypeLeft = 1,
    BCTTransitionSideTypeBottom = 2,
    BCTTransitionSideTypeRight = 3,

    //corners
    BCTTransitionSideTypeTopLeftCorner = 4,
    BCTTransitionSideTypeBottomLeftCorner = 5,
    BCTTransitionSideTypeBottomRightCorner = 6,
    BCTTransitionSideTypeTopRightCorner = 7,
};

#endif /* BCTTypes_h */
