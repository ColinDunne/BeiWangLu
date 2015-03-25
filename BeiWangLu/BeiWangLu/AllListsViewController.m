//
//  AllListsViewController.m
//  BeiWangLu
//
//  Created by 钱辰 on 3/13/15.
//  Copyright (c) 2015 qianchen. All rights reserved.
//

#import "AllListsViewController.h"
#import "BWLList.h"
#import "BWLTableViewController.h"

@interface AllListsViewController ()

@end

@implementation AllListsViewController

#pragma mark - Initialization

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.delegate = self;
    
    NSInteger index = [self.dataModel indexOfSelectedBWLList];
    
    if (index >= 0 && index < [self.dataModel.lists count]) {
        BWLList *list = [self.dataModel.lists objectAtIndex:index];
        [self performSegueWithIdentifier:@"Show List" sender:list];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataModel.lists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    BWLList *list = [self.dataModel.lists objectAtIndex:indexPath.row];
    cell.textLabel.text = list.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.dataModel setIndexOfSelectedChecklist:indexPath.row];
    
    BWLList *list = [self.dataModel.lists objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"Show List" sender:list];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    UINavigationController *naviController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"];
    
    ListDetailTableViewController *controller = (ListDetailTableViewController *)naviController.topViewController;
    controller.delegate = self;
    BWLList *list = [self.dataModel.lists objectAtIndex:indexPath.row];
    controller.listToEdit = list;
    
    [self presentViewController:naviController animated:YES completion:nil];
}

#pragma mark - Table View Data Source

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.dataModel.lists removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - List Detail View Delegate

- (void)listDetailViewControllerDidCancel:(ListDetailTableViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listDetailViewController:(ListDetailTableViewController *)controller didFinishAddingBWLList:(BWLList *)list {
    NSInteger newRowIndex = [self.dataModel.lists count];
    [self.dataModel.lists addObject:list];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listDetailViewController:(ListDetailTableViewController *)controller didFinishEditingBWLList:(BWLList *)list {
    NSInteger index = [self.dataModel.lists indexOfObject:list];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = list.name;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation Controller Delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController == self) {
        [self.dataModel setIndexOfSelectedChecklist:-1];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Show List"]) {
        BWLTableViewController *controller = segue.destinationViewController;
        controller.bwlList = sender;
    } else if ([segue.identifier isEqualToString:@"Add List"]) {
        UINavigationController *naviController = segue.destinationViewController;
        ListDetailTableViewController *controller = (ListDetailTableViewController *)naviController.topViewController;
        controller.delegate = self;
        controller.listToEdit = nil;
    }
}

@end
