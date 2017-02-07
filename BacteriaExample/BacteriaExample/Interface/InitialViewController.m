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
@property (nonatomic, weak) IBOutlet UISlider *timeSlider;

@property (nonatomic, weak) IBOutlet UISlider *startXSlider;
@property (nonatomic, weak) IBOutlet UISlider *startYSlider;

@property (nonatomic, weak) IBOutlet UISlider *endXSlider;
@property (nonatomic, weak) IBOutlet UISlider *endYSlider;

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
    
    PresentedViewController *controllerToPresent = [self getController];
    
    //get first row
    AnimationBlockModel *blockModel = [self blockForIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    AnimationBlockModel *dismissedBlockModel = [self blockForIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    AnimationBlockModel *presentedCover = [self blockForIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    AnimationBlockModel *dismissedCover = [self blockForIndexPath:[NSIndexPath indexPathForRow:1 inSection:3]];
    
    controllerToPresent.
    presentFrom([blockModel numberOfSelectedValue]).
    dismissTo([dismissedBlockModel numberOfSelectedValue]).
    //    presentFrom(BCTTransitionSideTypeTop).
    //    dismissTo(BCTTransitionSideTypeTop).
    withPresentedTransitionType([presentedCover numberOfSelectedValue]).
    withDismissedTransitionType([dismissedCover numberOfSelectedValue]).
    presentStartScale(self.startXSlider.value, self.startYSlider.value).
    dismissEndScale(self.endXSlider.value, self.endYSlider.value).
    transite(self.timeSlider.value);
    
    
    [self presentViewController:controllerToPresent animated:YES completion:nil];
}

- (IBAction)actionSafari:(id)sender {
    PresentedViewController *controllerToPresent = [self getController];
    controllerToPresent.safari().transite(1.0f);
    [self presentViewController:controllerToPresent animated:YES completion:nil];
}

#pragma mark - Helpers

- (AnimationBlockModel *)blockForIndexPath:(NSIndexPath *)indexPath {
    //get row
    AnimationRowModel *rowModel = [[self.dataSource sectionAtIndex:indexPath.section] rowAtIndex:indexPath.row];
    return rowModel.block;
}

- (AnimationRowModel *)modelForIndexPath:(NSIndexPath *)indexPath {
    AnimationRowModel *rowModel = [[self.dataSource sectionAtIndex:indexPath.section] rowAtIndex:indexPath.row];
    return rowModel;
}

#pragma mark - Table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //get the block & model
    AnimationBlockModel *block = [self blockForIndexPath:indexPath];
    AnimationRowModel *row = [self modelForIndexPath:indexPath];
    
    [block setValueFromAdditional:row.values];
    
    if (block.collapsed) {
        [block expand];
    } else {
        [block collapse];
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table Data Source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.dataSource sectionAtIndex:section].name;
}

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
    AnimationRowModel *rowModel = [self modelForIndexPath:indexPath];
    
    
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
