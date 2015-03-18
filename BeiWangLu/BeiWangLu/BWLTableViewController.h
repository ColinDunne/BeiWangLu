//
//  BWLTableViewController.h
//  BeiWangLu
//
//  Created by 钱辰 on 15/3/9.
//  Copyright (c) 2015年 qianchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailTableViewController.h"
#import "BWLList.h"

@interface BWLTableViewController : UITableViewController <ItemDetailViewControllerDelegate>

@property (nonatomic, strong) BWLList *bwlList;

@end
