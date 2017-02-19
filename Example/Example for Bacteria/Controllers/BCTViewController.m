//
//  BCTViewController.m
//  Bacteria
//
//  Created by igorkislyuk on 02/18/2017.
//  Copyright (c) 2017 igorkislyuk. All rights reserved.
//

#import <Bacteria/UIViewController+Bacteria.h>

#import "BCTViewController.h"
#import "BCTPresentedViewController.h"

@interface BCTViewController ()

@property (weak, nonatomic) IBOutlet UIButton *testButton;

@end

@implementation BCTViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    BCTPresentedViewController *presented = segue.destinationViewController;
    presented.presentTransition(BCTTransitionFlip).fromDirection(BCTDirectionTop).dismissTransition(BCTTransitionPopRadial).popTo(self.testButton).withDuration(0.45);
}



@end
