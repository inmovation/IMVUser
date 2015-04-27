//
//  SFTabBarController.m
//  TCA
//
//  Created by shaohua.chen on 14-4-4.
//  Copyright (c) 2014年 shaohua.chen. All rights reserved.
//

#import "IMVThemeManager.h"

#import "IMVTabBarController.h"
#import "IMVTabBarItem.h"

@interface IMVTabBarController ()

@end

@implementation IMVTabBarController

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
        self.tabBar.barTintColor = [UIColor colorForTabBarBarTint];
        self.tabBar.tintColor = [UIColor colorForTabBarTint];
    }else {
        self.tabBar.tintColor = [UIColor colorForTabBarBarTint];
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorForTabBarItemTitleSelected], UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorForTabBarItemTitleNormal], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
#else
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorForTabBarItemTitleSelected], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorForTabBarItemTitleNormal], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
#endif
    
    UIImage *bgImage = [UIImage imageForTabBarBackground];
    if (bgImage) {
        self.tabBar.backgroundImage = bgImage;
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

- (void)setViewControllers:(NSArray *)viewControllers itemTitles:(NSArray *)itemTitles itemNormalImages:(NSArray *)normalImages itemSelectedImages:(NSArray *)selectedImages
{
    self.viewControllers = viewControllers;
    for (int i = 0; i < self.viewControllers.count; i++) {
        UIViewController *vc = [self.viewControllers objectAtIndex:i];
        IMVTabBarItem *tabBarItem = [[IMVTabBarItem alloc] init];
        tabBarItem.title = [itemTitles objectAtIndex:i];
        tabBarItem.normalImage = [UIImage imageForName:[normalImages objectAtIndex:i]];
        tabBarItem.highlightedImage = [UIImage imageForName:[selectedImages objectAtIndex:i]];
        vc.tabBarItem = tabBarItem;
    }
}


#pragma mark orientation
- (BOOL)shouldAutorotate
{
    return self.selectedViewController.shouldAutorotate;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return self.selectedViewController.supportedInterfaceOrientations;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return self.selectedViewController.shouldAutorotate;
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
