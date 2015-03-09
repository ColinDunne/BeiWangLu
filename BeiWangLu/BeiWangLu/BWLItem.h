//
//  BWLItem.h
//  BeiWangLu
//
//  Created by 钱辰 on 15/3/9.
//  Copyright (c) 2015年 qianchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWLItem : NSObject
@property (nonatomic,copy) NSString *text;
@property (nonatomic,assign) BOOL checked;

- (void)toggleChecked;
@end
