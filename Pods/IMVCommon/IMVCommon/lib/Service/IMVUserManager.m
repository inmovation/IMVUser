//
//  IMUserManager.m
//  MobileExam
//
//  Created by 陈少华 on 15/4/1.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//

#import "IMVUserManager.h"

#define IMUserManagerUserId @"IMUserManagerUserId"
#define IMUserManagerLogin @"IMUserManagerLogin"
#define IMUserManagerPassword @"IMUserManagerPassword"
#define IMUserManagerDisplayName @"IMUserManagerDisplayName"
#define IMUserManagerAutoLogin @"IMUserManagerAutoLogin"
#define IMUserManagerRememberPsw @"IMUserManagerRememberPsw"

@implementation IMVUserManager

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
        _login = [[NSUserDefaults standardUserDefaults] valueForKey:IMUserManagerLogin];
        _password = [[NSUserDefaults standardUserDefaults] valueForKey:IMUserManagerPassword];
        _userId = [[NSUserDefaults standardUserDefaults] valueForKey:IMUserManagerUserId];
        _displayName = [[NSUserDefaults standardUserDefaults] valueForKey:IMUserManagerDisplayName];
        _autoLogin = [[NSUserDefaults standardUserDefaults] boolForKey:IMUserManagerAutoLogin];
        _rememberPsw = [[NSUserDefaults standardUserDefaults] boolForKey:IMUserManagerRememberPsw];
    }
    return self;
}

- (void)setLogin:(NSString *)userName
{
    [[NSUserDefaults standardUserDefaults] setValue:userName forKey:IMUserManagerLogin];
    if ([[NSUserDefaults standardUserDefaults] synchronize]) {
        _login = userName;
    }
}

- (void)setPassword:(NSString *)password
{
    [[NSUserDefaults standardUserDefaults] setValue:password forKey:IMUserManagerPassword];
    if ([[NSUserDefaults standardUserDefaults] synchronize]) {
        _password = password;
    }
}

- (void)setUserId:(NSString *)userId
{
    [[NSUserDefaults standardUserDefaults] setValue:userId forKey:IMUserManagerUserId];
    if ([[NSUserDefaults standardUserDefaults] synchronize]) {
        _userId = userId;
    }
}

- (void)setDisplayName:(NSString *)displayName
{
    [[NSUserDefaults standardUserDefaults] setValue:displayName forKey:IMUserManagerDisplayName];
    if ([[NSUserDefaults standardUserDefaults] synchronize]) {
        _displayName = displayName;
    }
}

- (void)setAutoLogin:(BOOL)autoLogin
{
    [[NSUserDefaults standardUserDefaults] setBool:autoLogin forKey:IMUserManagerAutoLogin];
    if ([[NSUserDefaults standardUserDefaults] synchronize]) {
        _autoLogin = autoLogin;
    }
}

- (void)setRememberPsw:(BOOL)rememberPsw
{
    [[NSUserDefaults standardUserDefaults] setBool:rememberPsw forKey:IMUserManagerRememberPsw];
    if ([[NSUserDefaults standardUserDefaults] synchronize]) {
        _rememberPsw = rememberPsw;
    }
}

- (void)clearUser
{
    [self setUserId:nil];
    [self setPassword:nil];
    [self setLogin:nil];
    [self setDisplayName:nil];
    [self setAutoLogin:NO];
}

@end
