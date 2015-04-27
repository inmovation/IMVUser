//
//  UIFont+IMVTheme.m
//  IMVCommon
//
//  Created by 陈少华 on 15/4/10.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//

#import "UIFont+IMVTheme.h"
#import "IMVThemeManager.h"

@implementation UIFont (IMVTheme)

+ (UIFont *)fontForName:(NSString *)name
{
    return [[IMVThemeManager sharedInstence] fontForName:name];
}

+ (UIFont *)fontForNaviBarTitle
{
    return [self fontForName:IMVFontNaviBarTitle];
}

+ (UIFont *)fontForNaviBarItemTitle
{
    return [self fontForName:IMVFontNaviBarItemTitle];
}

+ (UIFont *)fontForTabBarItemTitle
{
    return [self fontForName:IMVFontTabBarItemTitle];
}

+ (UIFont *)fontForTextTitle
{
    return [self fontForName:IMVFontTextTitle];
}

+ (UIFont *)fontForTextDetail
{
    return [self fontForName:IMVFontTextDetail];
}

@end
