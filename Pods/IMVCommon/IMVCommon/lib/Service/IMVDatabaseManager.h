//
//  IMDatabase.h
//  MobileExam
//
//  Created by 陈少华 on 15/4/2.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//
#import <UIKit/UIKit.h>

@class IMVUserManager;

/**
 *  用于管理数据库，封装了版本管理，账号切换，如应用中使用了sqlite，建一个继承自IMVDatabaseManager的管理类
 *  一个应用里面只能有一个数据库管理者
 */
@interface IMVDatabaseManager : NSObject

/**
 *  当前版本号，用于数据迁移
 */
@property (assign, nonatomic) CGFloat dbversion;

/**
 *  数据库的名字
 *  默认应用名
 */
@property (strong, nonatomic) NSString *dbName;

/**
 *  数据库的路径地址：/应用的ducument路径/当前用户userId/dbName.sqlite
 */
@property (strong, readonly, nonatomic) NSString *dbPath;

/**
 *  用户账号管理者，会监听里面的userId的变化来切换dpPath
 *  默认是[IMVUserManager sharedInstance]，如果使用了IMVUserManager的子类来管理账号，那么需要设置为你使用的userManager，可以在get方法中设置
 */
@property (strong, nonatomic) IMVUserManager *userManager;

/**
 *  单例方法，在子类中可以直接使用该静态方法
 *  只能有一个子类，如果多个子类的话，多个子类会指向同一个静态对象，发生严重的错误，如果需要用到多个子类的话，请重写该方法
 + (instancetype)sharedInstence
 {
 static id sharedInstence = nil;
 static dispatch_once_t predicate;
 dispatch_once(&predicate, ^{
 sharedInstence = [[self alloc] init];
 });
 return sharedInstence;
 }
 *  @return 单例
 */
+ (instancetype)sharedInstence;

/**
 *  将数据库的初始化都放在这个方法中，比如创建表，数据迁移等，子类中重写该方法时，需要调用[super initialize]
 *  该方法会在init方法中调用, 子类中不能重写init方法，如果特殊情况需要重写init的话，请在里面调用initialize方法
 */
- (void)initialize;

@end
