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
    //both controllers moves parallel
    BCTTransitionFlatParallel = 0, //default
    //one controller 'stands still'
    BCTTransitionFlatCover,
    //flip animation
    BCTTransitionFlip,
    //safari tabs animation
    BCTTransitionSafari,
    //if controller appears from circle
    BCTTransitionPopRadial,
    //if controller appears from rectangle
    BCTTransitionPopLinear
};

//supported only by flat. Works in flip (only for 4 first type)
typedef NS_ENUM(NSUInteger, BCTDirectionType) {
    //
    BCTDirectionTop = 0,
    BCTDirectionLeft,
    BCTDirectionBottom,
    BCTDirectionRight,

    //corners
    BCTDirectionTopLeft,
    BCTDirectionBottomLeft,
    BCTDirectionBottomRight,
    BCTDirectionTopRight,
};

#endif /* BCTTypes_h */
