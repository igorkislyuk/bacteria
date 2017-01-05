//
// Created by Igor on 05/01/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import "BCTLocationPerformer.h"

@interface BCTParallelLocationPerformer : NSObject <BCTLocationPerformer>

// two views
// one point

@property (nonatomic, strong, readonly) UIView *presentedView;
@property (nonatomic, strong, readonly) UIView *dismissedView;

@property (nonatomic, readonly) CGPoint offsetPoint;

- (instancetype)initWithPresentedView:(UIView *)presentedView dismissedView:(UIView *)dismissedView offsetPoint:(CGPoint)offsetPoint;

- (UIView *)presentedViewBefore;
- (UIView *)dismissedViewBefore;
- (UIView *)presentedViewAfter;
- (UIView *)dismissedViewAfter;



@end