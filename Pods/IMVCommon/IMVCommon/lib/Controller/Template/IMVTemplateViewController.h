//
//  TemplateViewController.h
//  IMVCommon
//
//  Created by shaohua on 1/14/15.
//  Copyright (c) 2015 shaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMVThemeManager.h"

/**
 *  viewController的基类，所有项目中的viewController都应继承自该类
 */
@interface IMVTemplateViewController : UIViewController

/**
 *  当切换了主题时会自动调用该方法，在该方法里面设置和主题相关的颜色图片字体等
 *  设置主题都应该在viewController中触发，最好不要在单个view里面监听主题切换通知
 */
- (void)initTheme;

@end
