//
//  UIImage+IMVTheme.h
//  IMVCommon
//
//  Created by 陈少华 on 15/4/10.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  推荐使用这些方法来获取图片
 */
@interface UIImage (IMVTheme)

+ (UIImage *)imageForName:(NSString *)name;

+ (UIImage *)imageForTabBarBackground;
+ (UIImage *)imageForNaviBarBackground;
+ (UIImage *)imageForNetworkBrokenHint;
+ (UIImage *)imageForEmptyHint;

@end
