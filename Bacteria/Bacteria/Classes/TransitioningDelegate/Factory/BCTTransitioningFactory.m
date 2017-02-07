//
// Created by Igor on 07/02/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import "BCTTransitioningFactory.h"
#import "BCTSafariTransitioningController.h"
#import "BCTTransitioningController.h"


@implementation BCTTransitioningFactory {
    BCTTransitioningController *_transitioningController;
    BCTSafariTransitioningController *_safariTransitioningController;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _startScale = CGSizeMake(1, 1);
        _endScale = CGSizeMake(1, 1);
    }

    _transitioningController = [[BCTTransitioningController alloc] initWithValueObtainer:self];
    _safariTransitioningController = [[BCTSafariTransitioningController alloc] init];

    return self;
}


- (id <UIViewControllerTransitioningDelegate>)transitioningDelegate {
    return self.safariLike ? _safariTransitioningController : _transitioningController;
}

@end