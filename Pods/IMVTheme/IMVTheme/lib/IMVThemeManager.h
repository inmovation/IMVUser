//
//  IMVThemeManager.h
//  IMVCommon
//
//  Created by 陈少华 on 15/4/10.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMVTheme.h"
#import "UIImage+IMVTheme.h"
#import "UIFont+IMVTheme.h"
#import "UIColor+IMVTheme.h"

//以下几个必须得在theme.plist中定义
//字体大小
#define IMVFontNaviBarTitle @"naviBarTitleFont"
#define IMVFontNaviBarItemTitle @"naviBarItemTitleFont"
#define IMVFontTabBarItemTitle @"tabBarItemTitleFont"
#define IMVFontTextTitle @"textTitleFont"
#define IMVFontTextDetail @"textDetailFont"

//颜色
#define IMVColorNaviBarTint @"naviBarTintColor"
#define IMVColorNaviBarBarTint @"naviBarBarTintColor"
#define IMVColorNaviBarTitle @"naviBarTitleColor"
#define IMVColorNaviBarItemTitle @"naviBarItemTitleColor"
#define IMVColorTabBarTint @"tabBarTintColor"
#define IMVColorTabBarBarTint @"tabBarBarTintColor"
#define IMVColorTabBarItemTitleNormal @"tabBarItemTitleNormalColor"
#define IMVColorTabBarItemTitleSelected @"tabBarItemTitleSelectedColor"
#define IMVColorViewBackground @"viewBackgroundColor"
#define IMVColorViewContent @"viewContentColor"
#define IMVColorTextTitle @"textTitleColor"
#define IMVColorTextDetail @"textDetailColor"

//必须的图片图片，可选
#define IMVImageTabBarBackground @"tabBarBackgroundImage"
#define IMVImageNaviBarBackground @"naviBarBackgroundImage"
#define IMVImageNetworkBrokenHint @"networkBrokenHintImage"
#define IMVImageEmptyHint @"emptyHintImage"

#define IMVNotificationThemeChanged @"IMVNotificationThemeChanged"

/**
 *  主题管理类，支持切换主题
 */
@interface IMVThemeManager : NSObject

+ (instancetype)sharedInstence;

/**
 *  切换主题，当调用时，会发送IMVNotificationThemeChanged的通知，接收这些通知来处理主题切换
 *
 *  @param themeName 主题名，bundle（去除后缀），或者沙盒中的根文件夹名
 *  @param themeType 主题类型，bundle：直接添加到项目中的主题，比如默认主题
                             sandbox：下载到沙盒中的主题
 */
- (void)useTheme:(NSString *)themeName type:(IMVThemeType)themeType;

/**
 *  随主题更换的图片全都放在主题中，直接将图片放在bundle中
 *
 *  @param name 图片名，去除后缀和@2x，目前图片中必须有2x类型的图片，如果有文件夹则加上文件夹路径，比如setting/name
 *
 *  @return 图片
 */
- (UIImage *)imageForName:(NSString *)name;

/**
 *  随主题更换的颜色都在主题的theme.plist中定义（比如navi和tab的背景颜色及字体颜色），plist中value格式:r,g,b,alpha
 *
 *  @param name plist中的key
 *
 *  @return 当前使用主题中对应的颜色
 */
- (UIColor *)colorForName:(NSString *)name;

/**
 *  随主题更换的字体大小都在主题中的theme.plist中定义
 *
 *  @param name plist中的key
 *
 *  @return 当前使用主题中对应的字体大小
 */
- (UIFont *)fontForName:(NSString *)name;

@end
