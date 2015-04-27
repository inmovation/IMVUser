//
//  IMFileManager.m
//  MobileExam
//
//  Created by 陈少华 on 15/4/1.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//

#import "IMVFileManager.h"
#import "IMVUserManager.h"

@implementation IMVFileManager

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
    
    _fileManager = [NSFileManager defaultManager];
    NSString *rootPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:self.userManager.login];
    if ([_fileManager createDirectoryAtPath:rootPath withIntermediateDirectories:YES attributes:nil error:nil]) {
        _rootPath = rootPath;
    }
}

- (void)dealloc
{
    [self.userManager removeObserver:self forKeyPath:@"userId" context:nil];
}

- (IMVUserManager *)userManager
{
    return [IMVUserManager sharedInstence];
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
