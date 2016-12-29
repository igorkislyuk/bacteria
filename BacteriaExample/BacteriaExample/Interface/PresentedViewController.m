//
//  PresentedViewController.m
//  BAControllerTransitionExample
//
//  Created by Igor on 25/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import "PresentedViewController.h"

@interface PresentedViewController ()

@end

@implementation PresentedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)actionDismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
