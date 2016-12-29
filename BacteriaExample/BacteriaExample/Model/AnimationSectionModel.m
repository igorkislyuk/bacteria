//
// Created by Igor on 29/12/2016.
// Copyright (c) 2016 Igor Kislyuk. All rights reserved.
//

#import "AnimationSectionModel.h"

#import "AnimationRowModel.h"
#import "AnimationBlockModel.h"

@interface AnimationSectionModel ()

@property(nonatomic, strong) NSArray<__kindof AnimationBlockModel *> *blocks;

@end

@implementation AnimationSectionModel

- (instancetype)initWithBlocks:(NSArray<__kindof AnimationBlockModel *> *)blocks {
    self = [super init];
    if (self) {
        _blocks = blocks;
    }

    return self;
}


- (NSInteger)count {
    NSInteger i = 0;
    for (AnimationBlockModel *blockModel in self.blocks) {
        i += [blockModel count];
    }
    return i;
}

- (AnimationBlockModel *)blockAtIndex:(NSInteger)index {
    return [self.blocks objectAtIndex:index];
}

- (AnimationRowModel *)rowAtIndex:(NSUInteger)index {

    NSUInteger blockIndex = 0;
    NSUInteger indexCopy = index;

    //if index is bigger that first block count -> skip first block and decrease index
    AnimationBlockModel *blockModel = [self.blocks objectAtIndex:blockIndex];

    while (indexCopy > blockModel.count) {
        //get next block
        blockModel = [self.blocks objectAtIndex:blockIndex + 1];

        //decrease
        indexCopy -= [blockModel count];
    }

    return [blockModel rowAtIndex:indexCopy];
}


+ (instancetype)defaultForAnimationType {

    //type
    AnimationRowModel *defaultRow = [[AnimationRowModel alloc] initWithValues:@[@"Default"]];

    AnimationRowModel *t = [[AnimationRowModel alloc] initWithValues:@[@"Top"]];
    AnimationRowModel *l = [[AnimationRowModel alloc] initWithValues:@[@"Left"]];
    AnimationRowModel *b = [[AnimationRowModel alloc] initWithValues:@[@"Bottom"]];
    AnimationRowModel *r = [[AnimationRowModel alloc] initWithValues:@[@"Right"]];

    AnimationRowModel *tlc = [[AnimationRowModel alloc] initWithValues:@[@"Top-left"]];
    AnimationRowModel *blc = [[AnimationRowModel alloc] initWithValues:@[@"Bottom-left"]];
    AnimationRowModel *brc = [[AnimationRowModel alloc] initWithValues:@[@"Bottom-right"]];
    AnimationRowModel *trc = [[AnimationRowModel alloc] initWithValues:@[@"Top-right"]];

    //block
    AnimationBlockModel *typeBlock = [[AnimationBlockModel alloc] initWithRow:defaultRow
                                                               additionalRows:@[t, l, b, r, tlc, blc, brc, trc]];
    [typeBlock collapse];

    return [[self alloc] initWithBlocks:@[typeBlock]];
}


@end
