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
    presenting.name = @"Present from";

    //second section for dismiss
    AnimationSectionModel *dismissing = [AnimationSectionModel defaultForAnimationType];
    dismissing.name = @"Dismiss to";

    AnimationSectionModel *presentingTransition = [AnimationSectionModel defaultForTransitionType];
    presentingTransition.name = @"Transition for presentation";
    
    AnimationSectionModel *dismissedTransition = [AnimationSectionModel defaultForTransitionType];
    presentingTransition.name = @"Transition for dismissal";
    
    //each with 2 elements
    dataSource.sections = @[presenting, dismissing, presentingTransition, dismissedTransition];

    return dataSource;
}

- (NSInteger)count {
    return self.sections.count;
}

- (AnimationSectionModel *)sectionAtIndex:(NSInteger)index {
    return [self.sections objectAtIndex:index];
}


@end
