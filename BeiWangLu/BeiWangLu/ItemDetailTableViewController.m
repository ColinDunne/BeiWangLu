//
//  ItemDetailTableViewController.m
//  BeiWangLu
//
//  Created by 钱辰 on 15/3/10.
//  Copyright (c) 2015年 qianchen. All rights reserved.
//

#import "ItemDetailTableViewController.h"

@interface ItemDetailTableViewController ()

@end

@implementation ItemDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.itemToEdit != nil) {
        self.title = @"Edit Item";
        self.textField.text = self.itemToEdit.text;
        self.doneBarButton.enabled = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.textField becomeFirstResponder];
}

- (IBAction)cancel:(id)sender {
    //[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [self.delegate itemDetailViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender {
    //NSLog(@"%@",self.textField.text);
    //[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    if (self.itemToEdit == nil) {
        BWLItem *item = [[BWLItem alloc] init];
        item.text = self.textField.text;
        item.checked = NO;
        [self.delegate itemDetailViewController:self didFinishAddingItem:item];
    } else {
        self.itemToEdit.text = self.textField.text;
        [self.delegate itemDetailViewController:self didFinishEditingItem:self.itemToEdit];
    }
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"%@",newText);
    if ([newText length] > 0) {
        self.doneBarButton.enabled = YES;
    } else {
        self.doneBarButton.enabled = NO;
    }
    
    return YES;
}

@end
