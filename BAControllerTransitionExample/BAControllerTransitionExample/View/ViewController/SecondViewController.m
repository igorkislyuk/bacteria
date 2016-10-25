//
//  SecondViewController.m
//  BAControllerTransitionExample
//
//  Created by Igor on 25/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)actionDismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
