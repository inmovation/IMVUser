//
//  RestPage.h
//  RestTest
//
//  Created by 陈少华 on 15/1/15.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IMVRestPageSortDesc @"desc"
#define IMVRestPageSortAsc @"asc"

/**
 *  spring rest 框架的page
 */
@interface IMVRestPage : NSObject

@property (assign, nonatomic) NSInteger page;
@property (assign, nonatomic) NSInteger size;

@property (strong, nonatomic) NSString *sortName;
@property (strong, nonatomic) NSString *order;

- (void)next;
- (void)previous;
- (void)toPage:(NSInteger)page;

+ (instancetype)pageWithPage:(NSInteger)page;
+ (instancetype)pageWithPage:(NSInteger)page size:(NSInteger)size;
+ (instancetype)pageWithPage:(NSInteger)page size:(NSInteger)size sortName:(NSString *)sortName order:(NSString *)order;

- (NSDictionary *)dictionary;

@end
