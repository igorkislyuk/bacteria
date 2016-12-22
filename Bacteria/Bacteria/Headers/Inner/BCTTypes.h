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
    BCTTransitionTypeCover = 1
};

typedef NS_ENUM(NSUInteger, BCTTransitionSideType) {
    BCTTransitionSideTypeLeft,
    BCTTransitionSideTypeRight,
    BCTTransitionSideTypeTop,
    BCTTransitionSideTypeBottom,

    //corners
    BCTTransitionSideTypeTopLeftCorner,
    BCTTransitionSideTypeTopRightCorner,
    BCTTransitionSideTypeBottomLeftCorner,
    BCTTransitionSideTypeBottomRightCorner
};

#endif /* BCTTypes_h */
