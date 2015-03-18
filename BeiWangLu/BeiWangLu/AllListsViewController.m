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
        _lists = [[NSMutableArray alloc] initWithCapacity:20];
        
        BWLList *list = [[BWLList alloc] init];
        list.name = @"娱乐";
        [_lists addObject:list];
        
        list = [[BWLList alloc] init];
        list.name = @"工作";
        [_lists addObject:list];
        
        list = [[BWLList alloc] init];
        list.name = @"学习";
        [_lists addObject:list];
        
        list = [[BWLList alloc] init];
        list.name = @"家庭";
        [_lists addObject:list];
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Show List"]) {
        BWLTableViewController *controller = segue.destinationViewController;
        controller.bwlList = sender;
    }
}

@end
