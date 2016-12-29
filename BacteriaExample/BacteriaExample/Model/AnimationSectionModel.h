//
// Created by Igor on 29/12/2016.
// Copyright (c) 2016 Igor Kislyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AnimationRowModel;
@class AnimationBlockModel;

@interface AnimationSectionModel : NSObject

+ (instancetype)defaultForAnimationType;

@property (nonatomic, copy) NSString *name;

- (NSInteger)count;

- (AnimationBlockModel *)blockAtIndex:(NSInteger)index;
- (AnimationRowModel *)rowAtIndex:(NSUInteger)index;

- (instancetype)initWithBlocks:(NSArray<__kindof AnimationBlockModel *> *)blocks;


@end