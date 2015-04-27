//
//  IMVStyle.h
//  IMVCommon
//
//  Created by 陈少华 on 15/4/10.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    styleTypeFont = 0,
    styleTypeColor,
    styleTypeOther
}IMVThemeStyleType;

@interface IMVStyle : NSObject

@property (strong, nonatomic) NSString *value;
@property (assign, nonatomic) IMVThemeStyleType type;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)dictionary;

- (UIFont *)fontValue;
- (UIColor *)colorValue;

@end
