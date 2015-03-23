//
//  BWLList.m
//  BeiWangLu
//
//  Created by 钱辰 on 3/16/15.
//  Copyright (c) 2015 qianchen. All rights reserved.
//

#import "BWLList.h"

@implementation BWLList

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.items = [[NSMutableArray alloc] initWithCapacity:20];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"Name"];
        self.items = [aDecoder decodeObjectForKey:@"Items"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeObject:self.items forKey:@"Items"];
}

@end
