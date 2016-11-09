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
            @"fromRightSide-toLeftSide" : ^(UIViewController *viewController){viewController.fromRightSide().toLeftSide().transite(1.5f);},
            @"fromLeftSide-toTopSide" : ^(UIViewController *viewController){viewController.fromLeftSide().toTopSide().transite(1.5f);},
            @"fromTopSide-toBottomSide" : ^(UIViewController *viewController){viewController.fromTopSide().toBottomSide().transite(1.5f);},
            @"fromBottomSide-toRightSide" : ^(UIViewController *viewController){viewController.fromBottomSide().toRightSide().transite(1.5f);},
            @"fromPoint - {100, 100}-toLeftSide" : ^(UIViewController *viewController) {viewController.fromPoint(CGPointMake(100, 100)).toLeftSide().transite(1.5f);},
            
            //new from 11-09
            @"N: fromPoint - {200, 200}-toPoint - {200, 200}" : ^(UIViewController *viewController) {viewController.fromPoint(CGPointMake(100, 100)).toPoint(CGPointMake(100, 100)).typeFrom(BATransitionTypeCover).transite(1.5f);},
            @"N: from left cover - to left paraller" : ^(UIViewController *viewController) {viewController.fromLeftSide().toLeftSide().typeTo(BATransitionTypeParallel).typeFrom(BATransitionTypeCover).transite(1.5f);},
            @"N: from r cov - to t par" : ^(UIViewController *viewController) {viewController.fromRightSide().typeFrom(BATransitionTypeCover).toTopSide().transite(1.5f);},
            @"N: from b cov - to b cov" : ^(UIViewController *viewController) {viewController.fromBottomSide().toBottomSide().typeTo(BATransitionTypeCover).typeFrom(BATransitionTypeCover).transite(1.5f);},

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
