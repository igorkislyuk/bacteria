//
//  ViewController.m
//  BAControllerTransitionExample
//
//  Created by Igor on 20/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

#import <BAControllerTransition/BAControllerTransition.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    [self presentTestAlert];
}

- (IBAction)actionPresentSecond:(id)sender {
    
    //get second
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SecondViewController *secondViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SecondViewController class])];

    secondViewController.fromLocation(CGPointMake(CGRectGetWidth(self.view.bounds) / 2, CGRectGetHeight(self.view.bounds))).transite(.5f);

    [self presentViewController:secondViewController animated:YES completion:^{

    }];
    
    
}



@end
