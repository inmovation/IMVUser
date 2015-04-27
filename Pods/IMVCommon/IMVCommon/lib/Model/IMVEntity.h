//
//  IMVEntity.h
//  IMVCommon
//
//  Created by shaohua.chen on 14-4-4.
//  Copyright (c) 2014年 shaohua.chen. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  后台返回的json对象父类
 */
@interface IMVEntity : NSObject

/**
 *  json转对象
 *
 *  @param dictionary json
 *
 *  @return 对象
 */
- (instancetype)initWithDictionary:(id)dictionary;

/**
 *  对象转json
 *
 *  @return json
 */
- (NSDictionary *)dictionary;

@end
