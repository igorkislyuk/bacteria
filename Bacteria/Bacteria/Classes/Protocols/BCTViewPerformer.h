//
// Created by Igor on 05/01/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BCTViewPerformer <NSObject>
@required

@property (nonatomic, assign) CGPoint offsetPoint;
@property (nonatomic, assign) CGSize startScale, endScale; // in units

- (UIView *)presentedViewBefore;
- (UIView *)dismissedViewBefore;
- (UIView *)presentedViewAfter;
- (UIView *)dismissedViewAfter;

@end