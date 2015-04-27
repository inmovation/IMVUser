//
//  UIFont+IMVTheme.h
//  IMVCommon
//
//  Created by 陈少华 on 15/4/10.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  推荐使用这些方法来获字体大小
 */
@interface UIFont (IMVTheme)

+ (UIFont *)fontForName:(NSString *)name;

+ (UIFont *)fontForNaviBarTitle;
+ (UIFont *)fontForNaviBarItemTitle;
+ (UIFont *)fontForTabBarItemTitle;
+ (UIFont *)fontForTextTitle;
+ (UIFont *)fontForTextDetail;

@end
