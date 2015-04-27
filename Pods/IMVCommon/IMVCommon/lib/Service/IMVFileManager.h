//
//  IMFileManager.h
//  MobileExam
//
//  Created by 陈少华 on 15/4/1.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IMVUserManager;

/**
 *  用于管理文件，封装账号切换，提供了一个默认的根路径，如需要实现其他功能（比如文件下载），请继承该类
 *  一个应用里面只能有一个文件管理者
 */
@interface IMVFileManager : NSObject

/**
 *  根路径：/应用document路径/当前用户userId/
 *  子目录应该在该目录下创建
 */
@property (strong, readonly, nonatomic) NSString *rootPath;

@property (strong, readonly, nonatomic) NSFileManager *fileManager;

/**
 *  用户账号管理者，会监听里面的userId的变化来切换rootPath
 *  默认是[IMVUserManager sharedInstance]，如果使用了IMVUserManager的子类来管理账号，那么需要设置为你使用的userManager，可以在get方法中设置
 */
@property (strong, nonatomic) IMVUserManager *userManager;

/**
 *  单例方法，在子类中可以直接使用该静态方法
 *  只能有一个子类，如果多个子类的话，多个子类会指向同一个静态对象，发生严重的错误，如果需要用到多个子类的话，请重写该方法，使用如下代码
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
 *  将文件的初始化都放在这个方法中，比如创建子目录等，子类中重写该方法时，需要调用[super initialize]
 *  该方法会在init方法中调用, 子类中不能重写init方法，如果特殊情况需要重写init的话，请在里面调用initialize方法
 */
- (void)initialize;

@end
