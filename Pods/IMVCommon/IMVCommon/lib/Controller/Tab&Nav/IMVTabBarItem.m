//
//  SFTabBarItem.m
//
//  Created by shaohua.chen on 14-4-4.
//  Copyright (c) 2014年 shaohua.chen. All rights reserved.
//

#import "IMVTabBarItem.h"

@implementation IMVTabBarItem

- (UIImage *)selectedImage
{
    if ([UIDevice currentDevice].systemVersion.floatValue>=7.0) {
        return [_highlightedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    else
    {
        return _highlightedImage;
    }
}


- (UIImage *)unselectedImage
{
    if ([UIDevice currentDevice].systemVersion.floatValue>=7.0) {
        return [_normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    else
    {
        return _normalImage;
    }
}

@end
