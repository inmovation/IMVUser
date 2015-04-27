//
//  SFNavigationController.m
//  TCA
//
//  Created by shaohua.chen on 14-4-4.
//  Copyright (c) 2014年 shaohua.chen. All rights reserved.
//
#import "IMVThemeManager.h"

#import "IMVNavigationController.h"

@implementation IMVNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)initTheme
{
    if ([UIDevice currentDevice].systemVersion.floatValue>=7.0) {
        self.navigationBar.barTintColor = [UIColor colorForNaviBarBarTint];
        self.navigationBar.tintColor = [UIColor colorForNaviBarTint];
    }else {
        self.navigationBar.tintColor = [UIColor colorForNaviBarBarTint];
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000

    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor colorForNaviBarTitle], UITextAttributeTextColor,
                                    [UIFont fontForNaviBarTitle], UITextAttributeFont,
                                    nil];
#else
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor colorForNaviBarTitle], NSForegroundColorAttributeName,
                                    [UIFont fontForNaviBarTitle], NSFontAttributeName,
                                    nil];
#endif
    self.navigationBar.titleTextAttributes = textAttributes;
    
    UIImage *naviBarBgImage = [UIImage imageForNaviBarBackground];
    if (naviBarBgImage) {
        self.navigationBar.backIndicatorImage = naviBarBgImage;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initTheme];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initTheme) name:IMVNotificationThemeChanged object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return [self.topViewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
}

- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
