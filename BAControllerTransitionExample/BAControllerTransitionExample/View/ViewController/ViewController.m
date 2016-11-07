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

typedef void (^ViewControllerPresentingBlock)(UIViewController *viewController);

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSDictionary<NSString *, ViewControllerPresentingBlock> *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataSource = @{
            @"fromRightSide" : ^(UIViewController *viewController){viewController.fromRightSide().transite(1.5f);},
            @"fromLeftSide" : ^(UIViewController *viewController){viewController.fromLeftSide().transite(1.5f);},
            @"fromTopSide" : ^(UIViewController *viewController){viewController.fromTopSide().transite(1.5f);},
            @"fromBottomSide" : ^(UIViewController *viewController){viewController.fromBottomSide().transite(1.5f);},
            @"fromPoint - {100, 100}" : ^(UIViewController *viewController) {viewController.fromPoint(CGPointMake(100, 100)).transite(1.5f);}

    };

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self presentTestAlert];
}

- (SecondViewController *)getController {
    //get second
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SecondViewController *secondViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SecondViewController class])];
    return secondViewController;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    //get key
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *key = cell.textLabel.text;

    //get action
    SecondViewController *secondViewController = [self getController];

    ViewControllerPresentingBlock block = self.dataSource[key];
    block(secondViewController);

    [self presentViewController:secondViewController animated:YES completion:^{

    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    //get key
    NSString *key = self.dataSource.allKeys[indexPath.row];

    cell.textLabel.text = key;


    return cell;
}


@end
