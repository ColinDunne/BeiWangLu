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

@implementation AllListsViewController {
    NSMutableArray *_lists;
}

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self loadBWLLists];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_lists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    BWLList *list = [_lists objectAtIndex:indexPath.row];
    cell.textLabel.text = list.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BWLList *list = [_lists objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"Show List" sender:list];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    UINavigationController *naviController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"];
    
    ListDetailTableViewController *controller = (ListDetailTableViewController *)naviController.topViewController;
    controller.delegate = self;
    BWLList *list = [_lists objectAtIndex:indexPath.row];
    controller.listToEdit = list;
    
    [self presentViewController:naviController animated:YES completion:nil];
}

#pragma mark - Table View Data Source

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [_lists removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - List Detail View Delegate

- (void)listDetailViewControllerDidCancel:(ListDetailTableViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listDetailViewController:(ListDetailTableViewController *)controller didFinishAddingBWLList:(BWLList *)list {
    NSInteger newRowIndex = [_lists count];
    [_lists addObject:list];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listDetailViewController:(ListDetailTableViewController *)controller didFinishEditingBWLList:(BWLList *)list {
    NSInteger index = [_lists indexOfObject:list];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = list.name;
    
    [self dismissViewControllerAnimated:YES completion:nil];
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

#pragma mark - Save & Load

- (NSString *)documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    return documentsDirectory;
}

- (NSString *)dataFilePath {
    return [[self documentsDirectory] stringByAppendingPathComponent:@"BWLList.plist"];
}

- (void)saveBWLLists {
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:_lists forKey:@"BWLList"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

- (void)loadBWLLists {
    NSString *path = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        _lists = [unarchiver decodeObjectForKey:@"BWLList"];
        [unarchiver finishDecoding];
    } else {
        _lists = [[NSMutableArray alloc] initWithCapacity:20];
    }
}

@end
