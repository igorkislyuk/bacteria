//
//  BCTInitialViewController.m
//  Bacteria
//
//  Created by Igor Kislyuk on 02/18/2017.
//  Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#import <Bacteria/UIViewController+Bacteria.h>

#import "BCTInitialViewController.h"
#import "BCTPresentedViewController.h"

@interface BCTInitialViewController ()

@property (weak, nonatomic) IBOutlet UIButton *testButton;

@end

@implementation BCTInitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //get presented controller
    BCTPresentedViewController *presented = segue.destinationViewController;
    
    //bacteria configuration
    presented.
    presentTransition(BCTTransitionFlatCover).
    fromDirection(BCTDirectionBottomLeft).
    fromScale(0.5, 0.5).
    dismissTransition(BCTTransitionFlip).
    toDirection(BCTDirectionBottom).
    withDuration(0.45f);
    
}

- (IBAction)actionPresentSafariDismissParallel:(id)sender {
    BCTPresentedViewController *presented = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([BCTPresentedViewController class])];
    
    presented.
    presentTransition(BCTTransitionSafari).
    dismissTransition(BCTTransitionFlatParallel).
    toDirection(BCTDirectionTop).
    withDuration(1.45f);
    
    [self presentViewController:presented animated:YES completion:nil];
}



@end
