//
//  BWLTableViewController.m
//  BeiWangLu
//
//  Created by 钱辰 on 15/3/9.
//  Copyright (c) 2015年 qianchen. All rights reserved.
//

#import "BWLTableViewController.h"
#import "BWLItem.h"

@interface BWLTableViewController ()

@end

@implementation BWLTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.bwlList.name;
}

- (void)configureCheckmarkForCell:(UITableViewCell *)cell withBWLItem:(BWLItem *)item {
    UILabel *checkLabel = (UILabel *)[cell viewWithTag:1001];
    
    if (item.checked) {
        checkLabel.text = @"√";
    } else {
        checkLabel.text = @"";
    }
}

- (void)configureTextForCell:(UITableViewCell *)cell withBWLItem:(BWLItem *)item {
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = item.text;
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.bwlList.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Item" forIndexPath:indexPath];
    
    BWLItem *item  = [self.bwlList.items objectAtIndex:indexPath.row];
    
    [self configureTextForCell:cell withBWLItem:item];
    [self configureCheckmarkForCell:cell withBWLItem:item];
    
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    BWLItem *item  = [self.bwlList.items objectAtIndex:indexPath.row];
    [item toggleChecked];
    
    [self configureCheckmarkForCell:cell withBWLItem:item];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.bwlList.items removeObjectAtIndex:indexPath.row];

        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Item Detail View Controller Delegate

- (void)itemDetailViewControllerDidCancel:(ItemDetailTableViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailViewController:(ItemDetailTableViewController *)controller didFinishAddingItem:(BWLItem *)item {
    NSInteger newRowIndex = [self.bwlList.items count];
    [self.bwlList.items addObject:item];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailViewController:(ItemDetailTableViewController *)controller didFinishEditingItem:(BWLItem *)item {
    NSInteger index = [self.bwlList.items indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    [self configureTextForCell:cell withBWLItem:item];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddItem"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailTableViewController *controller = (ItemDetailTableViewController *)navigationController.topViewController;
        controller.delegate = self;
    } else if ([segue.identifier isEqualToString:@"EditItem"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailTableViewController *controller = (ItemDetailTableViewController *)navigationController.topViewController;
        controller.delegate = self;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        controller.itemToEdit = [self.bwlList.items objectAtIndex:indexPath.row];
    }
}

@end
