//
//  AddItemTableViewController.m
//  BeiWangLu
//
//  Created by 钱辰 on 15/3/10.
//  Copyright (c) 2015年 qianchen. All rights reserved.
//

#import "AddItemTableViewController.h"

@interface AddItemTableViewController ()

@end

@implementation AddItemTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.textField becomeFirstResponder];
}

- (IBAction)cancel:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done:(id)sender {
    NSLog(@"%@",self.textField.text);
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
