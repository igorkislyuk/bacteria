//
// Created by Igor on 10/01/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import "BCTParallelViewDismissal.h"


@implementation BCTParallelViewDismissal {

}

- (UIView *)presentedViewBefore {

    UIView *result = self.presentedView;
    result.transform = CGAffineTransformTranslate(self.presentedTransform, self.offsetPoint.x, self.offsetPoint.y);
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