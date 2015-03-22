//
//  ListDetailTableViewController.m
//  BeiWangLu
//
//  Created by 钱辰 on 3/22/15.
//  Copyright (c) 2015 qianchen. All rights reserved.
//

#import "ListDetailTableViewController.h"

@interface ListDetailTableViewController ()

@end

@implementation ListDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.listToEdit != nil) {
        self.title = @"Edit List";
        self.textField.text = self.listToEdit.name;
        self.doneBarButton.enabled = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

- (IBAction)cancel:(id)sender {
    [self.delegate listDetailViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender {
    if (self.listToEdit == nil) {
        BWLList *list = [[BWLList alloc] init];
        list.name = self.textField.text;
        
        [self.delegate listDetailViewController:self didFinishAddingBWLList:list];
    } else {
        self.listToEdit.name = self.textField.text;
        [self.delegate listDetailViewController:self didFinishEditingBWLList:self.listToEdit];
    }
}

#pragma mark - UI Table View Delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - UI Text Field Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([newText length] > 0) {
        self.doneBarButton.enabled = YES;
    } else {
        self.doneBarButton.enabled = NO;
    }
    
    return YES;
}

@end
