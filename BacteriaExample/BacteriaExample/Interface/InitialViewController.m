//
//  InitialViewController.m
//  BAControllerTransitionExample
//
//  Created by Igor on 20/10/16.
//  Copyright © 2016 Igor Kislyuk. All rights reserved.
//

#import "InitialViewController.h"
#import "PresentedViewController.h"

#import <Bacteria/Bacteria.h>

#import "DataSource.h"
#import "AnimationSectionModel.h"
#import "AnimationRowModel.h"
#import "AnimationBlockModel.h"

@interface InitialViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) DataSource *dataSource;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataSource = [DataSource default];

}

- (PresentedViewController *)getController {
 
    //get second
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PresentedViewController *secondViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PresentedViewController class])];
    return secondViewController;
}

#pragma mark - IBActions

- (IBAction)actionShowNextController:(id)sender {
    [self presentViewController:[self getController] animated:YES completion:nil];
}

#pragma mark - Helpers

- (AnimationBlockModel *)blockForIndexPath:(NSIndexPath *)indexPath {
    //get row
    AnimationRowModel *rowModel = [[self.dataSource sectionAtIndex:indexPath.section] rowAtIndex:indexPath.row];
    return rowModel.block;
}

#pragma mark - Table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    AnimationBlockModel *blockModel = [self blockForIndexPath:indexPath];

    if (blockModel.collapsed) {
        [blockModel expand];
    } else {
        [blockModel collapse];
    }

    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.dataSource sectionAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSString *text = @"";

    //get model
    AnimationRowModel *rowModel = [[self.dataSource sectionAtIndex:indexPath.section] rowAtIndex:indexPath.row];


    if (rowModel.values.count > 1) {
        for (NSString *string in rowModel.values) {
            text = [text stringByAppendingString:[NSString stringWithFormat:@"%@ ", string]];
        }
    } else {
        text = [rowModel.values firstObject];
    }

    cell.textLabel.text = text;


    return cell;
}


@end
