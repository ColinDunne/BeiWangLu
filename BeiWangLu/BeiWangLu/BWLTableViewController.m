//
//  BWLTableViewController.m
//  BeiWangLu
//
//  Created by 钱辰 on 15/3/9.
//  Copyright (c) 2015年 qianchen. All rights reserved.
//

#import "BWLTableViewController.h"

@interface BWLTableViewController ()

@end

@implementation BWLTableViewController {
    NSString *_row0text;
    NSString *_row1text;
    NSString *_row2text;
    NSString *_row3text;
    NSString *_row4text;
    BOOL _row0checked;
    BOOL _row1checked;
    BOOL _row2checked;
    BOOL _row3checked;
    BOOL _row4checked;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _row0text = @"观看嫦娥⻜飞天和⽟玉兔升空的视频";
    _row1text = @"了解Sony a7和MBP的最新价格";
    _row2text = @"复习苍⽼老师的经典视频教程";
    _row3text = @"去电影院看地⼼心引⼒力";
    _row4text = @"看⻄西甲巴萨新败的⽐比赛回放";
}

- (void)configureCheckmarkForCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    BOOL isChecked = NO;
    
    if (indexPath.row == 0) {
        isChecked = _row0checked;
    } else if (indexPath.row == 1) {
        isChecked = _row1checked;
    } else if (indexPath.row == 2) {
        isChecked = _row2checked;
    } else if (indexPath.row == 3) {
        isChecked = _row2checked;
    } else if (indexPath.row == 4) {
        isChecked = _row3checked;
    }
    
    if (isChecked) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Item" forIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    
    if(indexPath.row == 0) {
        label.text = _row0text;
    } else if (indexPath.row == 1) {
        label.text = _row1text;
    } else if (indexPath.row == 2) {
        label.text = _row2text;
    } else if (indexPath.row == 3) {
        label.text = _row3text;
    } else if (indexPath.row == 4) {
        label.text = _row4text;
    }
    
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    BOOL isChecked = NO;
    if (indexPath.row == 0) {
        _row0checked = !_row0checked;
        isChecked = _row0checked;
    } else if(indexPath.row == 1) {
        _row1checked = !_row1checked;
        isChecked = _row1checked;
    } else if (indexPath.row == 2) {
        _row2checked = !_row2checked;
        isChecked = _row2checked;
    } else if (indexPath.row == 3) {
        _row3checked = !_row3checked;
        isChecked = _row3checked;
    } else if(indexPath.row == 4) {
        _row4checked = !_row4checked;
        isChecked = _row4checked;
    }
    
    if (isChecked) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
