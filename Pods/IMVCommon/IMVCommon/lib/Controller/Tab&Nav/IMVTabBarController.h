//
//  SFTabBarController.h
//  TCA
//
//  Created by shaohua.chen on 14-4-4.
//  Copyright (c) 2014年 shaohua.chen. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  从配置中读取样式，支持切换
 */
@interface IMVTabBarController : UITabBarController

/**
 *  是否透明，支持ios5，效果等同于tabBar.translucent，
 */
@property (assign, nonatomic) BOOL translucent;

/**
 *  tabbarItem的颜色
 */
@property (strong, nonatomic) UIColor *tintColor;

/**
 *  背景颜色
 */
@property (strong, nonatomic) UIColor *barTintColor;

/**
 *  item选择title颜色
 */
@property (strong, nonatomic) UIColor *itemSelectedTitleColor;

/**
 *  item未选中title颜色
 */
@property (strong, nonatomic) UIColor *itemNormalTitleColor;

/**
 *  背景图片
 */
@property (strong, nonatomic) UIImage *barBackgroundImage;

/**
 *  设置tabbar
 *
 *  @param viewControllers viewControllsers
 *  @param itemTitles      item的title
 *  @param normalImages    未选中的item图片
 *  @param selectedImages  选中的titem图片
 */
- (void)setViewControllers:(NSArray *)viewControllers itemTitles:(NSArray *)itemTitles itemNormalImages:(NSArray *)normalImages itemSelectedImages:(NSArray *)selectedImages;

@end
