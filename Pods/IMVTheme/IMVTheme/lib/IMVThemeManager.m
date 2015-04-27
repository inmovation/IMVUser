//
//  IMVThemeManager.m
//  IMVCommon
//
//  Created by 陈少华 on 15/4/10.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//

#import "IMVThemeManager.h"
#import "IMVTheme.h"

@interface IMVThemeManager ()

@property (strong, nonatomic) IMVTheme *theme;

@end
@implementation IMVThemeManager

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
        
    }
    return self;
}

- (void)useTheme:(NSString *)themeName type:(IMVThemeType)themeType
{
    if (!themeName || themeName.length<=0) {
        NSLog(@"error: you can't use theme with name:nil");
        return;
    }
    if ([self.theme.name isEqualToString:themeName]) {
        return;
    }
    _theme = [IMVTheme themeWithName:themeName type:themeType];
    [[NSNotificationCenter defaultCenter] postNotificationName:IMVNotificationThemeChanged object:themeName];
}

- (UIImage *)imageForName:(NSString *)name
{
    return [self.theme imageForName:name];
}

- (UIColor *)colorForName:(NSString *)name
{
    return [self.theme colorForName:name];
}

- (UIFont *)fontForName:(NSString *)name
{
    return [self.theme fontForName:name];
}

@end
