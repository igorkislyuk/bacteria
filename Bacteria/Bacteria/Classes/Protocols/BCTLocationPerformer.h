//
// Created by Igor on 05/01/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BCTLocationPerformer <NSObject>
@required


- (UIView *)presentedViewBeforeWith:(UIView *)view withOffset:(CGPoint)point;
- (UIView *)dismissedViewBeforeWith:(UIView *)view withOffset:(CGPoint)point;

- (UIView *)presentedViewAfterWith:(UIView *)view withOffset:(CGPoint)point;
- (UIView *)dismissedViewAfterWith:(UIView *)view withOffset:(CGPoint)point;

@end