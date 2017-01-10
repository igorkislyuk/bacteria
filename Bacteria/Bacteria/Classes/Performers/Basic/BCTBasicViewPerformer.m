//
// Created by Igor on 05/01/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import "BCTBasicViewPerformer.h"

@implementation BCTBasicViewPerformer {
}

- (instancetype)initWithPresentedView:(UIView *)presentedView dismissedView:(UIView *)dismissedView {

    self = [super init];
    if (self) {
        _presentedView = presentedView;
        _dismissedView = dismissedView;

        _offsetPoint = CGPointZero;

        //generate transforms
        _presentedTransform = presentedView.transform;
        _dismissedTransform = dismissedView.transform;
    }

    return self;
}

@end