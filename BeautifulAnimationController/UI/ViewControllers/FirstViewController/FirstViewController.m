//
//  FirstViewController.m
//  BeautifulAnimationController
//
//  Created by Igor on 24/09/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

#import "UIViewController+BAAnimationController.h"

@interface FirstViewController () <UIViewControllerTransitioningDelegate>



@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionShowSecond:(id)sender {
    SecondViewController *secondViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([SecondViewController class])];
    
    [secondViewController wrapWithTestAnimationController];
    
    [self presentViewController:secondViewController animated:YES completion:nil];

}



@end
