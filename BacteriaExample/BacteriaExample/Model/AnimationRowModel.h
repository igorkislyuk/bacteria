//
// Created by Igor on 29/12/2016.
// Copyright (c) 2016 Igor Kislyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnimationRowModel : NSObject

@property (nonatomic) NSArray<__kindof NSString *> *values;
- (instancetype)initWithValues:(NSArray *)values;


@end