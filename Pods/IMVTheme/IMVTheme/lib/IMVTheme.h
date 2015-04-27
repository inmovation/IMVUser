//
//  IMVTheme.h
//  IMVCommon
//
//  Created by 陈少华 on 15/4/10.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMVStyle.h"

typedef enum{
    themeTypeBundle = 0,
    themeTypeSandbox
}IMVThemeType;

@interface IMVTheme : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) IMVThemeType type;

@property (strong, nonatomic) NSMutableDictionary *styles;

+ (instancetype)themeWithName:(NSString *)name type:(IMVThemeType)themeType;

- (NSDictionary *)dictionary;

- (BOOL)synchronize;

- (UIFont *)fontForName:(NSString *)name;
- (UIColor *)colorForName:(NSString *)name;
- (UIImage *)imageForName:(NSString *)name;

@end
