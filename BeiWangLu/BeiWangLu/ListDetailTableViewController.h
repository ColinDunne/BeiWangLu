//
//  ListDetailTableViewController.h
//  BeiWangLu
//
//  Created by 钱辰 on 3/22/15.
//  Copyright (c) 2015 qianchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BWLList.h"

@class ListDetailTableViewController;

@protocol ListDetailViewControllerDelegate <NSObject>

- (void)listDetailViewControllerDidCancel:(ListDetailTableViewController *)controller;
- (void)listDetailViewController:(ListDetailTableViewController *)controller didFinishAddingBWLList:(BWLList *)list;
- (void)listDetailViewController:(ListDetailTableViewController *)controller didFinishEditingBWLList:(BWLList *)list;

@end


@interface ListDetailTableViewController : UITableViewController <ListDetailViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic, weak) id <ListDetailViewControllerDelegate> delegate;

@property (nonatomic, strong) BWLList *listToEdit;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
