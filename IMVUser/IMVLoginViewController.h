//
//  IMVLoginViewController.h
//  IMVUser
//
//  Created by Creolophus on 4/27/15.
//  Copyright (c) 2015 inmovation. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface IMVLoginViewController : UIViewController
@property (strong, nonatomic) BOOL(^loginHandler)(NSString *userName, NSString *password);


//style
@property (strong, nonatomic) UIColor *titleLabelColor;

@property (strong, nonatomic) UIFont *titleLabelFont;

@property (strong, nonatomic) UIColor *textFieldColor;

@property (strong, nonatomic) UIColor *placeholderColor;

@property (strong, nonatomic) UIColor *loginButtonColor;

@property (assign, nonatomic) CGFloat loginButtonCornerRadius;

@property (strong, nonatomic) UIColor *loginButtonTextColor;




//position
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gapConstraint;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *loginButtonLeftConstraint;
@end
