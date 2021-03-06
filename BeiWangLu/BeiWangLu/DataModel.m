//
//  DataModel.m
//  BeiWangLu
//
//  Created by 钱辰 on 3/24/15.
//  Copyright (c) 2015 qianchen. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadBWLLists];
        [self registerDefaults];
    }
    return self;
}

- (void)registerDefaults {
    NSDictionary *dictionary = @{@"BWLListIndex" : @-1};
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

#pragma mark - Get & Set Current Index

- (NSInteger)indexOfSelectedBWLList {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"BWLListIndex"];
}

- (void)setIndexOfSelectedChecklist:(NSInteger)index {
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"BWLListIndex"];
}

#pragma mark - Save & Load

- (NSString *)documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    return documentsDirectory;
}

- (NSString *)dataFilePath {
    return [[self documentsDirectory] stringByAppendingPathComponent:@"BWLLists.plist"];
}

- (void)saveBWLLists {
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.lists forKey:@"BWLLists"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

- (void)loadBWLLists {
    NSString *path = [self dataFilePath];
    NSLog(@"%@", path);
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        self.lists = [unarchiver decodeObjectForKey:@"BWLLists"];
        
        [unarchiver finishDecoding];
    } else {
        self.lists = [[NSMutableArray alloc] initWithCapacity:20];
    }
}

@end
