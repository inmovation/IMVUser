//
//  IMDatabase.m
//  MobileExam
//
//  Created by 陈少华 on 15/4/2.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//

#import "IMVUserManager.h"
#import "IMVDatabaseManager.h"

@implementation IMVDatabaseManager

+ (instancetype)sharedInstence
{
    static id sharedInstence = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstence = [[self alloc] init];
    });
    return sharedInstence;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initialize];
        [self.userManager addObserver:self forKeyPath:@"userId" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

- (void)initialize
{
    
    NSString *rootPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:self.userManager.login];
    if ([[NSFileManager defaultManager] createDirectoryAtPath:rootPath withIntermediateDirectories:YES attributes:nil error:nil]) {
        _dbPath = [rootPath stringByAppendingPathComponent:self.dbName];
    }
}

- (void)dealloc
{
    [self.userManager removeObserver:self forKeyPath:@"userId" context:nil];
}

- (NSString *)dbName
{
    return [NSString stringWithFormat:@"%@.sqlite", [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey]];
}

- (IMVUserManager *)userManager
{
    return [IMVUserManager sharedInstence];
}

- (NSString *)dbVersionKey
{
    return [NSString stringWithFormat:@"%@_dbversion", self.userManager.login];
}

- (void)setDbversion:(CGFloat)dbversion
{
    [[NSUserDefaults standardUserDefaults] setFloat:dbversion forKey:[self dbVersionKey]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (CGFloat)dbversion
{
    CGFloat dbversion = [[NSUserDefaults standardUserDefaults] floatForKey:[self dbVersionKey]];
    return dbversion;
}


#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.userManager) {
        if ([keyPath isEqualToString:@"userId"]) {
            NSString *new = [change objectForKey:@"new"];
            NSString *old = [change objectForKey:@"old"];
            if (new && ![new isEqual:[NSNull null]] && ![new isEqualToString:old]) {
                [self initialize];
            }
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
@end
