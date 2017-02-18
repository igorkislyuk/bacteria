//
// Created by Igor on 08/01/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import "BCTCoverViewDismissal.h"


@implementation BCTCoverViewDismissal

- (UIView *)presentedViewBefore {
    return self.presentedView;
}

- (UIView *)dismissedViewBefore {

    UIView *result = self.dismissedView;
    result.transform = self.dismissedTransform;
    return result;
}

- (UIView *)presentedViewAfter {
    return self.presentedView;
}

- (UIView *)dismissedViewAfter {

    UIView *result = self.dismissedView;

    CGAffineTransform transform = CGAffineTransformTranslate(self.dismissedTransform, -self.offsetPoint.x, -self.offsetPoint.y);
    result.transform = CGAffineTransformScale(transform, self.endScale.width, self.endScale.height);

    return result;
}

@end