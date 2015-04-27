//
//  IMVLoginViewController.m
//  IMVUser
//
//  Created by Creolophus on 4/27/15.
//  Copyright (c) 2015 inmovation. All rights reserved.
//

#import "IMVLoginViewController.h"
#import <IMVUserManager.h>
#import <SVProgressHUD.h>
#import <UIImage+IMVTheme.h>

#define IMVUserUserIcon                         @"user/login/login_icon_user"
#define IMVUserPasswordIcon                     @"user/login/login_icon_password"
#define IMVUserAutoLoginUncheck                 @"user/login/login_icon_tick_normal"
#define IMVUserAutoLoginChecked                 @"user/login/login_icon_tick_selected"
#define IMVUserBackgroundImage                  @"user/login/login_background"
#define IMVUserLoginBtnBackgroundNormal         @"user/login/login_button_background_normal"
#define IMVUserLoginBtnBackgroundHighlighted    @"user/login/login_button_background_highlighted"

#define IMVUserBodyViewTopConstraintKeyboardShow 30

@interface IMVLoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@property (weak, nonatomic) IBOutlet UIView *bodyView;
    @property (weak, nonatomic) IBOutlet UIImageView *userImageView;
    @property (weak, nonatomic) IBOutlet UITextField *userTextField;
    @property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;
    @property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
    @property (weak, nonatomic) IBOutlet UIButton *autoLoginButton;
    @property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bodyViewTopConstraint;

@end

@implementation IMVLoginViewController{
    CGFloat titleLabelTopConstraintDefault;
    CGFloat bodyViewTopConstraintDefault;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    titleLabelTopConstraintDefault = _titleLabelTopConstraint.constant;
    bodyViewTopConstraintDefault = _bodyViewTopConstraint.constant;
    
    _userImageView.image = [UIImage imageForName:IMVUserUserIcon];
    _passwordImageView.image = [UIImage imageForName:IMVUserPasswordIcon];
    [_autoLoginButton setBackgroundImage:[UIImage imageForName:IMVUserAutoLoginUncheck] forState:UIControlStateNormal];
    [_autoLoginButton setBackgroundImage:[UIImage imageForName:IMVUserAutoLoginChecked] forState:UIControlStateSelected];
    
    NSString *bgImageName = [IMVUserBackgroundImage stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)[UIScreen mainScreen].bounds.size.height]];
    [_loginButton setBackgroundImage:[UIImage imageForName:IMVUserLoginBtnBackgroundNormal] forState:UIControlStateNormal];
    [_loginButton setBackgroundImage:[UIImage imageForName:IMVUserLoginBtnBackgroundHighlighted] forState:UIControlStateHighlighted];

    
    _backgroundImageView.image = [UIImage imageForName:bgImageName];
    _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;

    _userTextField.text = [IMVUserManager sharedInstence].login;
    _passwordTextField.text = [IMVUserManager sharedInstence].password;
    _autoLoginButton.selected = [IMVUserManager sharedInstence].autoLogin;

    
    _titleLabel.textColor = _titleLabelColor;
    if (_titleLabelFont) {
        _titleLabel.font = _titleLabelFont;
    }
    _userTextField.textColor = _textFieldColor;
    _passwordTextField.textColor = _textFieldColor;
    if (_placeholderColor) {
        [_userTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"输入用户名" attributes:@{NSForegroundColorAttributeName: _placeholderColor}]];
        [_passwordTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"输入密码" attributes:@{NSForegroundColorAttributeName: _placeholderColor}]];
    }
    
    [_loginButton setBackgroundColor:_loginButtonColor];
    _loginButton.layer.cornerRadius = _loginButtonCornerRadius;
    [_loginButton setTitleColor:_loginButtonTextColor forState:UIControlStateNormal];


    [self addKeyboardObserver];
    
}


-(void)addKeyboardObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHeightWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardHeightWillChange:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    animationDuration = animationDuration>0.15?animationDuration:0.15;
    CGRect beginKeyboardRect = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endkeyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];


    CGRect screenRect = [UIScreen mainScreen].bounds;
    //Animation
    CGFloat alpha;
    if (beginKeyboardRect.origin.y < endkeyboardRect.origin.y && (endkeyboardRect.origin.y - beginKeyboardRect.origin.y >200)) {
        alpha = 1.f;
        _titleLabelTopConstraint.constant = titleLabelTopConstraintDefault;
        _bodyViewTopConstraint.constant = bodyViewTopConstraintDefault;
    }else{
        //判断登陆按钮是否会被键盘遮挡,不会则不执行动画
        if (screenRect.size.height - _bodyView.frame.size.height - _bodyView.frame.origin.y >= beginKeyboardRect.size.height) {
            return;
        }
        alpha = 0.f;
        _titleLabelTopConstraint.constant = 0;
        _bodyViewTopConstraint.constant = IMVUserBodyViewTopConstraintKeyboardShow;
    }

    [UIView animateWithDuration:animationDuration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _titleLabel.alpha = alpha;
        [self.view layoutIfNeeded];
    } completion:nil];
//    [UIView animateWithDuration:animationDuration animations:^{
//        _titleLabel.alpha = alpha;
//        [self.view layoutIfNeeded];
//    } completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_userTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

- (IBAction)autoLoginBtnClicked:(id)sender {
    _autoLoginButton.selected = !_autoLoginButton.selected;
}

- (IBAction)loginButtonClicked:(id)sender {
    if (_userTextField.text.length<=0) {
        [SVProgressHUD showInfoWithStatus:@"用户名不能为空"];
        return;
    }
    if (_passwordTextField.text.length<=0) {
        [SVProgressHUD showInfoWithStatus:@"密码不能为空"];
        return;
    }
    self.loginHandler(_userTextField.text, _passwordTextField.text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)slide1:(id)sender {
    UISlider *slide = sender;
    _leftConstraint.constant = slide.value;
}

- (IBAction)slide2:(id)sender {
    UISlider *slide = sender;
    _gapConstraint.constant = slide.value;
}

- (IBAction)slide3:(id)sender {
    UISlider *slide = sender;
    _loginButtonLeftConstraint.constant = slide.value;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
