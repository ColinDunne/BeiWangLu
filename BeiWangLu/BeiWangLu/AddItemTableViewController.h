//
//  AddItemTableViewController.h
//  BeiWangLu
//
//  Created by 钱辰 on 15/3/10.
//  Copyright (c) 2015年 qianchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BWLItem.h"

@class AddItemTableViewController;

@protocol AddItemViewControllerDelegate <NSObject>

- (void)addItemViewControllerDidCancel:(AddItemTableViewController *)controller;

- (void)addItemViewController:(AddItemTableViewController *)controller didFinishAddingItem:(BWLItem *)item;

@end

@interface AddItemTableViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak, nonatomic) id <AddItemViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;

- (IBAction)done:(id)sender;

@end
