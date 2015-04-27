//
//  IMVTheme.m
//  IMVCommon
//
//  Created by 陈少华 on 15/4/10.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//

#import "IMVTheme.h"
#import "IMVStyle.h"


@interface IMVTheme ()

@property (strong, nonatomic) NSString *plistPath;

@end

@implementation IMVTheme

+ (instancetype)themeWithName:(NSString *)name type:(IMVThemeType)themeType
{
    if (!name || name.length<=0) {
        NSLog(@"error: theme name can't be nil!");
        return nil;
    }
    
    NSString *plistPath = nil;
    if (themeType == themeTypeBundle) {
        NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:name ofType:@"bundle"]];
        plistPath = [bundle pathForResource:@"theme" ofType:@"plist"];
    }
    if (!plistPath || plistPath.length<=0) {
        NSLog(@"error: plist of theme:%@ not exist!", name);
        return nil;
    }
    
    IMVTheme *theme = [[IMVTheme alloc] init];
    theme.styles = [NSMutableDictionary dictionary];
    theme.type = themeType;
    theme.name = name;
    theme.plistPath = plistPath;
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:theme.plistPath];
    for (NSString *key in dic.allKeys) {
        NSDictionary *value = dic[key];
        IMVStyle *style = [[IMVStyle alloc] initWithDictionary:value];
        [theme.styles setObject:style forKey:key];
    }
    
    return theme;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (NSString *key in self.styles.allKeys) {
        IMVStyle *style = self.styles[key];
        [dic setObject:[style dictionary] forKey:key];
    }
    return dic;
}

- (BOOL)synchronize
{
    if (!self.plistPath) {
        return NO;
    }
    return [[self dictionary] writeToFile:self.plistPath atomically:YES];
}

- (UIImage *)imageForName:(NSString *)name
{
    NSString *imgPath = nil;
    if (self.type == themeTypeBundle) {
        NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:self.name ofType:@"bundle"]];
        // 必须保证有2x图片
        imgPath = [bundle pathForResource:[NSString stringWithFormat:@"%@@2x", name] ofType:@"png"];
    }

//    return [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", self.name, name]];
    
    imgPath = [imgPath stringByDeletingPathExtension];
    return [UIImage imageWithContentsOfFile:imgPath];

}

- (UIColor *)colorForName:(NSString *)name
{
    IMVStyle *style = [self.styles objectForKey:name];
    if (!style) {
        NSLog(@"the color named:%@ not in the theme:%@", name, self.name);
        return nil;
    }
    return style.colorValue;
}

- (UIFont *)fontForName:(NSString *)name
{
    IMVStyle *style = [self.styles objectForKey:name];
    if (!style) {
        NSLog(@"the font named:%@ not in the theme:%@", name, self.name);
        return nil;
    }
    return style.fontValue;
}
@end
