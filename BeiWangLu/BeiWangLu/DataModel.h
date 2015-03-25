//
//  DataModel.h
//  BeiWangLu
//
//  Created by 钱辰 on 3/24/15.
//  Copyright (c) 2015 qianchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (nonatomic, strong) NSMutableArray *lists;

- (void)saveBWLLists;

@end
