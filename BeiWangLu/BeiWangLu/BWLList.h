//
//  BWLList.h
//  BeiWangLu
//
//  Created by 钱辰 on 3/16/15.
//  Copyright (c) 2015 qianchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWLList : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *items;

@end
