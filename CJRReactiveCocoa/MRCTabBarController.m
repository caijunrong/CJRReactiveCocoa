//
//  MRCTabBarController.m
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/2.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import "MRCTabBarController.h"

#import "MRCNavigationController.h"
#import "CategoryViewController.h"
#import "MyNewsViewController.h"
#import "NewsViewModel.h"

@interface MRCTabBarController ()

@property (nonatomic, strong, readwrite) UITabBarController *tabBarController;

@end

@implementation MRCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.view.frame = self.view.bounds;
    
    [self addChildViewController:self.tabBarController];
    [self.view addSubview:self.tabBarController.view];
    
    [[self
      rac_signalForSelector:@selector(tabBarController:didSelectViewController:)
      fromProtocol:@protocol(UITabBarControllerDelegate)]
     subscribeNext:^(RACTuple *tuple) {
         NSLog(@"tuple:%@",tuple.second);
         MRCSharedAppDelegate.navigationController = tuple.second;
     }];
    
    self.tabBarController.delegate = self;

}

- (void)bindViewModel{
    
    //1.0
    NewsViewModel *nsViewModel = [[NewsViewModel alloc]initWithParams:nil];
    nsViewModel.titleViewType = MRCTitleViewTypeDefault;
    nsViewModel.shouldPullToRefresh = YES;
    MyNewsViewController *newVC = [[MyNewsViewController alloc]initWithViewModel:nsViewModel];
    
    newVC.tabBarItem.image = [UIImage imageNamed:@"首页09gray"];
//    newVC.tabBarItem.selectedImage = [UIImage imageNamed:@"首页09red"];
    newVC.tabBarItem.title = @"首页";
    
    MRCNavigationController *mrcNC = [[MRCNavigationController alloc]initWithRootViewController:newVC];
    
    //2.0
    CategoryViewController *catVC = [[CategoryViewController alloc]init];
    catVC.tabBarItem.image = [UIImage imageNamed:@"搜索09gray"];
    catVC.tabBarItem.title = @"花边";
    MRCNavigationController *catNC = [[MRCNavigationController alloc]initWithRootViewController:catVC];
    self.tabBarController.viewControllers = @[mrcNC,catNC];
    
    //初始化一下navigationbar的值
    MRCSharedAppDelegate.navigationController = self.tabBarController.viewControllers.firstObject;
    
    NSLog(@"MRCSharedAppDelegate.navigationController :%@",MRCSharedAppDelegate.navigationController );
    
    
    //如果使用了通知中心，收到某个通知，调用setSelectedIndex来切换tabBarController页面的话，要顺带把MRCSharedAppDelegate.navigationController也一并修改.
//    [self.tabBarController setSelectedIndex:1];
}




- (BOOL)shouldAutorotate {
    return self.tabBarController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.tabBarController.supportedInterfaceOrientations;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.tabBarController.preferredStatusBarStyle;
}

#pragma mark - UITabBarControllerDelegate

- (UIInterfaceOrientationMask)tabBarControllerSupportedInterfaceOrientations:(UITabBarController *)tabBarController {
    return tabBarController.selectedViewController.supportedInterfaceOrientations;
}

@end

@interface UITabBarController (MRCStatusBarAddtions)

@end

@implementation UITabBarController (MRCStatusBarAddtions)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(preferredStatusBarStyle);
        SEL swizzledSelector = @selector(mrc_preferredStatusBarStyle);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark - Method Swizzling

- (UIStatusBarStyle)mrc_preferredStatusBarStyle {
    return self.selectedViewController.preferredStatusBarStyle;
}

@end
