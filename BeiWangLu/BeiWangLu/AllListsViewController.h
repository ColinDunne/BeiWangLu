//
//  AllListsViewController.h
//  BeiWangLu
//
//  Created by 钱辰 on 3/13/15.
//  Copyright (c) 2015 qianchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"
#import "ListDetailTableViewController.h"

@interface AllListsViewController : UITableViewController <ListDetailViewControllerDelegate>

@property (nonatomic, strong) DataModel *dataModel;

@end
