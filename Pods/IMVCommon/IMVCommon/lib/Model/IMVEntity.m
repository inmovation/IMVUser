//
//  TCAJsonObject.m
//  TCA
//
//  Created by shaohua.chen on 14-4-4.
//  Copyright (c) 2014年 shaohua.chen. All rights reserved.
//

#import "IMVEntity.h"

@implementation IMVEntity

- (id)initWithDictionary:(id)dic
{
    self = [super init];
    if (self) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            [self setValuesForKeysWithDictionary:dic];
        }
        else
        {
            NSLog(@"object init failed, not dictionary");
        }
    }
    return self;
}

- (NSDictionary *)dictionary
{
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"key(%@.%@) is not found", NSStringFromClass([self class]), key);
}

-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

-(BOOL)allowsKeyedCoding{
    return YES;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    IMVEntity *entity = [[IMVEntity allocWithZone:zone] init];
    return entity;
}

-(id)copyWithZone:(NSZone *)zone{
    IMVEntity *entity = [[IMVEntity allocWithZone:zone] init];
    return entity;
}

@end
