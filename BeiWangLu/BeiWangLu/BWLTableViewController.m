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

@implementation BWLTableViewController {
    NSMutableArray *_items;
}

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self loadBWLItems];
    }
    
    return self;
}

- (void)loadBWLItems {
    NSString *path = [self dataFilePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        _items = [unarchiver decodeObjectForKey:@"BWLItems"];
        [unarchiver finishDecoding];
    } else {
        _items = [[NSMutableArray alloc] initWithCapacity:10];
    }
}

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
    // Return the number of rows in the section.
    return [_items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Item" forIndexPath:indexPath];
    
    BWLItem *item  = [_items objectAtIndex:indexPath.row];
    
    [self configureTextForCell:cell withBWLItem:item];
    [self configureCheckmarkForCell:cell withBWLItem:item];
    
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    BWLItem *item  = [_items objectAtIndex:indexPath.row];
    [item toggleChecked];
    
    [self configureCheckmarkForCell:cell withBWLItem:item];
    [self saveBWLItems];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_items removeObjectAtIndex:indexPath.row];
        [self saveBWLItems];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Item Detail View Controller Delegate

- (void)itemDetailViewControllerDidCancel:(ItemDetailTableViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailViewController:(ItemDetailTableViewController *)controller didFinishAddingItem:(BWLItem *)item {
    NSInteger newRowIndex = [_items count];
    [_items addObject:item];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self saveBWLItems];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailViewController:(ItemDetailTableViewController *)controller didFinishEditingItem:(BWLItem *)item {
    NSInteger index = [_items indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    [self configureTextForCell:cell withBWLItem:item];
    [self saveBWLItems];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
        controller.itemToEdit = [_items objectAtIndex:indexPath.row];
    }
}

#pragma mark - File Saving

- (NSString *)documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    
    return documentsDirectory;
}

- (NSString *)dataFilePath {
    return [[self documentsDirectory] stringByAppendingPathComponent:@"BWLItems.plist"];
}

- (void)saveBWLItems {
    // serialization
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:_items forKey:@"BWLItems"];
    [archiver finishEncoding];
    
    // saving
    [data writeToFile:[self dataFilePath] atomically:YES];
}

@end
