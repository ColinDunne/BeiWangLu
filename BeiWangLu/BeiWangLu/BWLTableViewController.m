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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _items = [[NSMutableArray alloc] initWithCapacity:20];
    BWLItem *_item = [[BWLItem alloc] init];
    _item = [[BWLItem alloc] init];
    _item.text = @"观看嫦娥⻜天和⽟兔升空的视频";
    _item.checked = YES;
    [_items addObject:_item];
    
    _item = [[BWLItem alloc] init];
    _item.text = @"了解Sony a7和MBP的最新价格";
    _item.checked = NO;
    [_items addObject:_item];
    
    _item = [[BWLItem alloc] init];
    _item.text = @"复习iOS的经典视频教程";
    _item.checked = YES;
    [_items addObject:_item];
    
    _item = [[BWLItem alloc] init];
    _item.text = @"去电影院看地⼼引⼒";
    _item.checked = NO;
    [_items addObject:_item];
    
    _item = [[BWLItem alloc] init];
    _item.text = @"看西甲巴萨新败的⽐赛回放";
    _item.checked = YES;
    [_items addObject:_item];
}

- (void)configureCheckmarkForCell:(UITableViewCell *)cell withBWLItem:(BWLItem *)item {
    if (item.checked) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
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
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_items removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Add Item View Controller Delegate

- (void)addItemViewControllerDidCancel:(AddItemTableViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addItemViewController:(AddItemTableViewController *)controller didFinishAddingItem:(BWLItem *)item {
    NSInteger newRowIndex = [_items count];
    [_items addObject:item];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
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
        AddItemTableViewController *controller = (AddItemTableViewController *)navigationController.topViewController;
        controller.delegate = self;
    }
}

@end
