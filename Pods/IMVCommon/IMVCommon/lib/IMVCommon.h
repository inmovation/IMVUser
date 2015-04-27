//
//  IMCommon.h
//  Common
//
//  Created by 陈少华 on 15/4/2.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//

#import <DDLog.h>
#import <DDTTYLogger.h>
#import <DDASLLogger.h>
#import <DDFileLogger.h>

#import "IMVThemeManager.h"

#import "IMVNavigationController.h"
#import "IMVTabBarController.h"
#import "IMVTabBarItem.h"
#import "IMVTemplateViewController.h"
#import "IMVTemplateViewController+PickImage.h"
#import "IMVUserManager.h"
#import "IMVDatabaseManager.h"
#import "IMVFileManager.h"
#import "IMVEntity.h"
#import "IMVRestEntity.h"
#import "IMVRestPage.h"

#ifdef DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_OFF;
#endif