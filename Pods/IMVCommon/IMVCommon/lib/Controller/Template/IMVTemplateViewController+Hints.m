//
//  IMVTemplateViewController+Hints.m
//  IMVCommon
//
//  Created by 陈少华 on 15/4/14.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//
#import <UIImage+IMVTheme.h>

#import "IMVTemplateViewController+Hints.h"

@implementation IMVTemplateViewController (Hints)

static UIView *networkErrorView;
static UIView *emptyView;
static UILabel *emptyLabel;

+ (UIView *)networkErrorView
{
    if (!networkErrorView) {
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        networkErrorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        networkErrorView.backgroundColor = [UIColor colorForViewBackgroud];
        
        UIImageView *networkBrokenImgView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth/2.0-116.0/2, 90, 116, 82)];
        networkBrokenImgView.image = [UIImage imageForNetworkBrokenHint];
        [networkErrorView addSubview:networkBrokenImgView];
        
        UILabel *networkErrorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, screenWidth, 20)];
        networkErrorLabel.text = @"加载失败";
        networkErrorLabel.textColor = [UIColor colorWithWhite:50.0/255 alpha:1.0];
        networkErrorLabel.font = [UIFont systemFontOfSize:18.0f];
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
        networkErrorLabel.textAlignment = UITextAlignmentCenter;
#else
        networkErrorLabel.textAlignment = NSTextAlignmentCenter;
#endif
        networkErrorLabel.backgroundColor = [UIColor clearColor];
        [networkErrorView addSubview:networkErrorLabel];
        
        UILabel *tryAgainLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 230, screenWidth, 20)];
        tryAgainLabel.textColor = [UIColor colorWithWhite:120.0/255 alpha:1.0];
        tryAgainLabel.text = @"请检查您的手机是否联网，点击按钮重新加载";
        tryAgainLabel.font = [UIFont systemFontOfSize:14.0];
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
        tryAgainLabel.textAlignment = UITextAlignmentCenter;
#else
        tryAgainLabel.textAlignment = NSTextAlignmentCenter;
#endif
        tryAgainLabel.backgroundColor = [UIColor clearColor];
        [networkErrorView addSubview:tryAgainLabel];
        
        UIButton *tryAgainButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [tryAgainButton setFrame:CGRectMake(screenWidth/2-60, 300, 120, 40)];
        [tryAgainButton setTitle:@"重新加载" forState:UIControlStateNormal];
        [tryAgainButton setTitleColor:[UIColor colorWithWhite:2550.0/255 alpha:1.0] forState:UIControlStateNormal];
        tryAgainButton.backgroundColor = [UIColor colorWithRed:0.0/255 green:133.0/255 blue:85.0/255 alpha:1.0];
        [tryAgainButton addTarget:self action:@selector(loadDataAgain) forControlEvents:UIControlEventTouchUpInside];
        [networkErrorView addSubview:tryAgainButton];
    }
    return networkErrorView;
}

+ (UIView *)emptyView
{
    if (!emptyView) {
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        emptyView.backgroundColor = [UIColor colorForViewBackgroud];

        UIImageView *emptyImgView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth/2.0-45.0/2, 125, 45, 45)];
        emptyImgView.image = [UIImage imageForEmptyHint];
        [emptyView addSubview:emptyImgView];
        
        emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, screenWidth, 20)];
        emptyLabel.textColor = [UIColor colorWithRed:191.0/255 green:191.0/255 blue:171.0/255 alpha:1.0];
        emptyLabel.font = [UIFont systemFontOfSize:18.0f];
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
        emptyLabel.textAlignment = UITextAlignmentCenter;
#else
        emptyLabel.textAlignment = NSTextAlignmentCenter;
#endif
        emptyLabel.backgroundColor = [UIColor clearColor];
        [emptyView addSubview:emptyLabel];
    }
    return emptyView;
}

- (void)showEmptyViewWithFrame:(CGRect)frame status:(NSString *)status
{
    [[IMVTemplateViewController emptyView] removeFromSuperview];
    [self.view addSubview:emptyView];
    [emptyView setFrame:frame];
    emptyLabel.text = status;
    [self.view bringSubviewToFront:emptyView];
}

- (void)hideEmptyView
{
    [[IMVTemplateViewController emptyView] removeFromSuperview];
}


- (void)showNetworkErrorWithFrame:(CGRect)frame
{
    [[IMVTemplateViewController networkErrorView] removeFromSuperview];
    [self.view addSubview:networkErrorView];
    [networkErrorView setFrame:frame];
}

- (void)hideNetworkErrorView
{
    [[IMVTemplateViewController networkErrorView] removeFromSuperview];
}

- (void)loadDataAgain
{
    
}

@end
