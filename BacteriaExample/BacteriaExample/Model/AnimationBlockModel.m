//
// Created by Igor on 29/12/2016.
// Copyright (c) 2016 Igor Kislyuk. All rights reserved.
//

#import "AnimationBlockModel.h"
#import "AnimationRowModel.h"


@interface AnimationBlockModel ()

@property (nonatomic) AnimationRowModel *row;
@property (nonatomic) NSArray<__kindof AnimationRowModel*> *additionalRows;

@property (nonatomic, assign, readwrite) BOOL collapsed;

@end

@implementation AnimationBlockModel {
    NSInteger _count;
}

- (instancetype)initWithRow:(AnimationRowModel *)row additionalRows:(NSArray *)additionalRows {
    self = [super init];
    if (self) {
        _row = row;
        _additionalRows = additionalRows;
        
        _count = 1;
    }

    return self;
}


- (NSInteger)count {
    return _count;
}

- (AnimationRowModel *)rowAtIndex:(NSInteger)index {
    if (index == 0) {
        return self.row;
    } else {
        return self.additionalRows[index - 1];
    }
}

- (void)collapse {

    self.collapsed = YES;
    _count = 1;
}

- (void)expand {

    self.collapsed = NO;
    _count = 1 + self.additionalRows.count;
}


@end
