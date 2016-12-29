//
// Created by Igor on 29/12/2016.
// Copyright (c) 2016 Igor Kislyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AnimationSectionModel;

@interface DataSource : NSObject

+ (instancetype)default;

- (NSInteger)count;
- (AnimationSectionModel *)sectionAtIndex:(NSInteger)index;

@end