//
// Created by Igor on 08/01/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import "BCTCoverViewPresenter.h"


@implementation BCTCoverViewPresenter

- (UIView *)presentedViewBefore {

    UIView *result = self.presentedView;
    CGAffineTransform transform = CGAffineTransformTranslate(self.presentedTransform, self.offsetPoint.x, self.offsetPoint.y);
    result.transform = CGAffineTransformScale(transform, self.startScale.width, self.startScale.height);
    return result;
}

- (UIView *)dismissedViewBefore {
    return self.dismissedView;
}

- (UIView *)presentedViewAfter {

    UIView *result = self.presentedView;
    result.transform = self.presentedTransform;
    return result;
}

- (UIView *)dismissedViewAfter {
    return self.dismissedView;
}

@end