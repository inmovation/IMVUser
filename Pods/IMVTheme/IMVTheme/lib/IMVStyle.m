//
//  IMVStyle.m
//  IMVCommon
//
//  Created by 陈少华 on 15/4/10.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//
#import "IMVStyle.h"

@interface IMVStyle ()

@property (strong, nonatomic) UIColor *colorValue;
@property (strong, nonatomic) UIFont *fontValue;

@end

@implementation IMVStyle

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:self.type] forKey:@"type"];
    [dic setObject:self.value?self.value:@"" forKey:@"value"];
     
    return dic;
}

- (UIFont *)fontValue
{
    if (self.type != styleTypeFont) {
        NSLog(@"warm: the theme style is not kind of font");
        return nil;
    }
    if (!_fontValue) {
        _fontValue = [UIFont systemFontOfSize:[self.value floatValue]];
    }
    return _fontValue;
}

- (UIColor *)colorValue
{
    if (self.type != styleTypeColor) {
        NSLog(@"warm: the theme style is not kind of color");
        return nil;
    }
    
    if (!_colorValue) {
        NSArray *rgb = [[self.value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsSeparatedByString:@","];
        if (rgb.count != 4) {
            NSLog(@"error: the themeStyle value format should be [r,g,b,alpha]");
            return nil;
        }
        _colorValue = [UIColor colorWithRed:[rgb[0] floatValue]/255 green:[rgb[1] floatValue]/255 blue:[rgb[2] floatValue]/255 alpha:[rgb[3] floatValue]];
    }
    
    return _colorValue;
}

@end
