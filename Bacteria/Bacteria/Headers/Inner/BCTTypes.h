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
    BCTTransitionTypeParallel = 0, //defaultForAnimationType
    BCTTransitionTypeCover = 1
};

typedef NS_ENUM(NSUInteger, BCTTransitionSideType) {
    BCTTransitionSideTypeLeft = 0,
    BCTTransitionSideTypeRight = 1,
    BCTTransitionSideTypeTop = 2,
    BCTTransitionSideTypeBottom = 3,

    //corners
    BCTTransitionSideTypeTopLeftCorner = 4,
    BCTTransitionSideTypeTopRightCorner = 5,
    BCTTransitionSideTypeBottomLeftCorner = 6,
    BCTTransitionSideTypeBottomRightCorner = 7
};

#endif /* BCTTypes_h */
