//
// Created by Igor on 29/12/2016.
// Copyright (c) 2016 Igor Kislyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AnimationRowModel;

@interface AnimationBlockModel : NSObject

//as defaultForAnimationType block always show only one cell.
- (instancetype)initWithRow:(AnimationRowModel *)row additionalRows:(NSArray *)additionalRows;

- (NSInteger)count;
- (AnimationRowModel *)rowAtIndex:(NSInteger)index;

- (void)setValueFromAdditional:(NSArray *)values;

- (NSUInteger)numberOfSelectedValue;

@property (nonatomic, assign, readonly) BOOL collapsed;
- (void)collapse;
- (void)expand;

@end