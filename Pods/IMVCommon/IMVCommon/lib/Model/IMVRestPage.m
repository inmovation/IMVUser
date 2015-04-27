//
//  RestPage.m
//  RestTest
//
//  Created by 陈少华 on 15/1/15.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//

#import "IMVRestPage.h"

@implementation IMVRestPage

- (void)next
{
    _page++;
}
- (void)previous
{
    _page--;
}

- (void)toPage:(NSInteger)page
{
    _page = page;
}

- (NSDictionary *)dictionary
{
    if (!self) {
        return nil;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":[NSNumber numberWithInteger:_page], @"size":[NSNumber numberWithInteger:_size]}];
    if (_sortName) {
        if (!_order || ![_order isEqualToString:IMVRestPageSortDesc]) {
            _order = IMVRestPageSortAsc;
        }
        [dic setObject:[NSString stringWithFormat:@"%@,%@", _sortName, _order] forKey:@"sort"];
    }
    return dic;
}

+ (instancetype)pageWithPage:(NSInteger)page
{
    return [self pageWithPage:page size:20 sortName:nil order:nil];
}

+ (instancetype)pageWithPage:(NSInteger)page size:(NSInteger)size
{
    return [self pageWithPage:page size:size sortName:nil order:nil];
}

+ (instancetype)pageWithPage:(NSInteger)page size:(NSInteger)size sortName:(NSString *)sortName order:(NSString *)order
{
    IMVRestPage *restPage = [[IMVRestPage alloc] init];
    restPage.page = page;
    restPage.size = size;
    restPage.sortName = sortName;
    restPage.order = order;
    return restPage;
}

@end
