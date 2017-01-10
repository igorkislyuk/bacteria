//
// Created by Igor on 10/01/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import "BCTParallelViewPresenter.h"

@implementation BCTParallelViewPresenter {

}

- (UIView *)presentedViewBefore {

    UIView *result = self.presentedView;

    CGAffineTransform transform = CGAffineTransformTranslate(self.presentedTransform, self.offsetPoint.x, self.offsetPoint.y);
    result.transform = CGAffineTransformScale(transform, self.startScale.width, self.startScale.height);

    return result;
}

- (UIView *)dismissedViewBefore {

    UIView *result = self.dismissedView;
    result.transform = self.dismissedTransform;
    return result;
}

- (UIView *)presentedViewAfter {

    UIView *result = self.presentedView;
    result.transform = self.presentedTransform;
    return result;
}

- (UIView *)dismissedViewAfter {

    UIView *result = self.dismissedView;

    CGAffineTransform transform = CGAffineTransformTranslate(self.dismissedTransform, -self.offsetPoint.x, -self.offsetPoint.y);
    result.transform = CGAffineTransformScale(transform, self.endScale.width, self.endScale.height);

    return result;
}

@end