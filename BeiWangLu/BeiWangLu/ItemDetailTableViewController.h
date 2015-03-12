//
//  ItemDetailTableViewController.h
//  BeiWangLu
//
//  Created by 钱辰 on 15/3/10.
//  Copyright (c) 2015年 qianchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BWLItem.h"

@class ItemDetailTableViewController;

@protocol ItemDetailViewControllerDelegate <NSObject>

- (void)itemDetailViewControllerDidCancel:(ItemDetailTableViewController *)controller;

- (void)itemDetailViewController:(ItemDetailTableViewController *)controller didFinishAddingItem:(BWLItem *)item;

- (void)itemDetailViewController:(ItemDetailTableViewController *)controller didFinishEditingItem:(BWLItem *)item;

@end

@interface ItemDetailTableViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, strong) BWLItem *itemToEdit;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak, nonatomic) id <ItemDetailViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;

- (IBAction)done:(id)sender;

@end
