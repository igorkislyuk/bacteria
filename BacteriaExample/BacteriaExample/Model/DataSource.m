//
// Created by Igor on 29/12/2016.
// Copyright (c) 2016 Igor Kislyuk. All rights reserved.
//

#import "DataSource.h"

#import "AnimationSectionModel.h"

@interface DataSource ()
@property (nonatomic, strong) NSArray <__kindof AnimationSectionModel *> *sections;
@end

@implementation DataSource

+ (instancetype)default {
    DataSource *dataSource = [[DataSource alloc] init];

    //first section for presenting
    AnimationSectionModel *presenting = [AnimationSectionModel defaultForAnimationType];
    presenting.name = @"Animation type for present";

    //second section for dismiss
    AnimationSectionModel *dismissing = [AnimationSectionModel defaultForAnimationType];
    dismissing.name = @"Animation type for dismiss";

    //each with 2 elements
    dataSource.sections = @[presenting, dismissing];

    return dataSource;
}

- (NSInteger)count {
    return self.sections.count;
}

- (AnimationSectionModel *)sectionAtIndex:(NSInteger)index {
    return [self.sections objectAtIndex:index];
}


@end