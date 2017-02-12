//
// Created by Igor on 07/02/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import "BCTTransitioning.h"

@interface BCTTransitioningFactory : NSObject <BCTTransitioning>

@property (nonatomic, assign) NSTimeInterval duration;

@property (nonatomic, assign) BOOL presenting;

@property (nonatomic, assign) BCTTransitionType presentTransitionType;
@property (nonatomic, assign) BCTTransitionType dismissTransitionType;

@property (nonatomic, assign) BCTDirectionType presentDirectionType;
@property (nonatomic, assign) BCTDirectionType dismissDirectionType;

@property (nonatomic, assign) CGSize startScale;
@property (nonatomic, assign) CGSize endScale;

@property (nonatomic, assign) CGPoint presentStartPoint;
@property (nonatomic, assign) CGPoint dismissEndPoint;

@property(nonatomic, assign) CGRect startPopRect;
@property(nonatomic, assign) CGRect endPopRect;

@end