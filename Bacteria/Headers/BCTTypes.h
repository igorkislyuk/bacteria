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
//    BCTTransitionNone = 0,
    
    //both controllers moves parallel
    BCTTransitionFlatParallel = 1, //default
    //one controller 'stands still'
    BCTTransitionFlatCover = 2,
    //flip animation
    BCTTransitionFlip = 3,
    //safari tabs animation
    BCTTransitionSafari = 4,
    //if controller appears from circle
    BCTTransitionPopRadial = 5,
    //if controller appears from rectangle
    BCTTransitionPopLinear = 6
};

//supported only by flat. Works in flip (only for 4 first type)
typedef NS_ENUM(NSUInteger, BCTDirectionType) {
//    BCTDirectionNone = 0,
    
    //
    BCTDirectionTop = 1,
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
