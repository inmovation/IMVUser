//
//  IMUserManager.h
//  MobileExam
//
//  Created by 陈少华 on 15/4/1.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  账号管理类，记录当前账号的信息，封装了读取写入NSUserDefault，如需要使用其他用户字段，请继承该类，在子类中添加，并且在子类中自行实现新字段的读写NSUserDefault
 */
@interface IMVUserManager : NSObject

/**
 *  用户id
 */
@property (strong, nonatomic) NSString *userId;

/**
 *  用户登录账号
 */
@property (strong, nonatomic) NSString *login;

/**
 *  用户显示名
 */
@property (strong, nonatomic) NSString *displayName;

/**
 *  密码
 */
@property (strong, nonatomic) NSString *password;

/**
 *  是否自动登录，可以在didFinishLaunchingWithOptions中判断是否自动登录
 */
@property (assign, nonatomic) BOOL autoLogin;

/**
 *  是否记住密码，可以在登录界面中使用改字段来判断是否记住密码
 */
@property (assign, nonatomic) BOOL rememberPsw;

/**
 *  单例方法，在子类中可以直接使用该静态方法，但是只能有一个子类，如果多个子类的话，多个子类会指向同一个静态对象，发生严重的错误
 *
 *  @return 单例
 */
+ (instancetype)sharedInstence;

/**
 *  清除当前账户信息，如果子类中有新字段需要清除，则重写该方法，并调用[super clearUser]
 */
- (void)clearUser;

@end
