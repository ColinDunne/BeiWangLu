//
//  AddItemTableViewController.h
//  BeiWangLu
//
//  Created by 钱辰 on 15/3/10.
//  Copyright (c) 2015年 qianchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddItemTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *textField;

- (IBAction)cancel:(id)sender;

- (IBAction)done:(id)sender;

@end
