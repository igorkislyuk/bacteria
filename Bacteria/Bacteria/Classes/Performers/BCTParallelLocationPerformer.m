//
// Created by Igor on 05/01/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import "BCTParallelLocationPerformer.h"

@implementation BCTParallelLocationPerformer {
    CGAffineTransform _pTransform, _dTransform;
}

- (instancetype)initWithPresentedView:(UIView *)presentedView dismissedView:(UIView *)dismissedView {

    self = [super init];
    if (self) {
        _presentedView = presentedView;
        _dismissedView = dismissedView;

        _offsetPoint = CGPointZero;

        //generate transforms
        _pTransform = presentedView.transform;
        _dTransform = dismissedView.transform;
    }

    return self;
}

- (UIView *)presentedViewBefore {

    UIView *result = self.presentedView;
    
    CGAffineTransform transform = CGAffineTransformTranslate(_pTransform, self.offsetPoint.x, self.offsetPoint.y);
    result.transform = CGAffineTransformScale(transform, self.startScale.width, self.startScale.height);
    
    return result;
}

- (UIView *)dismissedViewBefore {

    UIView *result = self.dismissedView;
    result.transform = _dTransform;
    return result;
}

- (UIView *)presentedViewAfter {

    UIView *result = self.presentedView;
    result.transform = _pTransform;
    return result;
}

- (UIView *)dismissedViewAfter {

    UIView *result = self.dismissedView;

    CGAffineTransform transform = CGAffineTransformTranslate(_dTransform, -self.offsetPoint.x, -self.offsetPoint.y);
    transform = CGAffineTransformScale(transform, self.endScale.width, self.endScale.height);
    result.transform = transform;
    
    return result;
}

@end