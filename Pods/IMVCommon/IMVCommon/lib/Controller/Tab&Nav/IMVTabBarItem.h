//
//  SFTabBarItem.h
//
//  Created by shaohua.chen on 14-4-4.
//  Copyright (c) 2014年 shaohua.chen. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  设置选中的图片，为了适配ios5
 */
@interface IMVTabBarItem : UITabBarItem

/**
 *  选中的图片
 */
@property (nonatomic, strong) UIImage *highlightedImage;

/**
 *  未选中图片
 */
@property (nonatomic, strong) UIImage *normalImage;

@end
