//
// Created by Igor on 29/12/2016.
// Copyright (c) 2016 Igor Kislyuk. All rights reserved.
//

#import "AnimationRowModel.h"


@implementation AnimationRowModel

- (instancetype)initWithValues:(NSArray *)values {
    self = [super init];
    if (self) {
        _values = values;
    }

    return self;
}

@end