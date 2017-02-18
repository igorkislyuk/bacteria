//
//  BCTViewController.m
//  Bacteria
//
//  Created by igorkislyuk on 02/18/2017.
//  Copyright (c) 2017 igorkislyuk. All rights reserved.
//

#import "BCTViewController.h"

#import "UIViewController+Bacteria.h"
#import "BCTPresentedViewController.h"

@interface BCTViewController ()

@property (weak, nonatomic) IBOutlet UIButton *testButton;

@end

@implementation BCTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    BCTPresentedViewController *presented = segue.destinationViewController;
    presented.presentTransition(BCTTransitionFlip).fromDirection(BCTDirectionTop).dismissTransition(BCTTransitionPopRadial).popTo(self.testButton).withDuration(0.45);
}



@end
