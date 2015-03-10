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
    _item.text = @"观看嫦娥⻜飞天和⽟玉兔升空的视频";
    _item.checked = YES;
    [_items addObject:_item];
    
    _item = [[BWLItem alloc] init];
    _item.text = @"了解Sony a7和MBP的最新价格";
    _item.checked = NO;
    [_items addObject:_item];
    
    _item = [[BWLItem alloc] init];
    _item.text = @"复习苍⽼老师的经典视频教程";
    _item.checked = YES;
    [_items addObject:_item];
    
    _item = [[BWLItem alloc] init];
    _item.text = @"去电影院看地⼼心引⼒力";
    _item.checked = NO;
    [_items addObject:_item];
    
    _item = [[BWLItem alloc] init];
    _item.text = @"看⻄西甲巴萨新败的⽐比赛回放";
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

- (IBAction)addItem:(id)sender {
    NSInteger num = [_items count];
    
    BWLItem *item = [[BWLItem alloc] init];
    item.text = @"我买的书什么时候才能到";
    item.checked = NO;
    [_items addObject:item];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:num inSection:0];
    NSArray *indexPaths = @[indexPath];
    
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
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
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
