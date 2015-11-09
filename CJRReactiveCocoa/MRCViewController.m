//
//  MRCViewController.m
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/2.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import "MRCViewController.h"
#import "MRCViewModel.h"
#import "MRCLoadingTitleView.h"




@interface MRCViewController()

@property (nonatomic, strong, readwrite) MRCViewModel *viewModel;

@end

@implementation MRCViewController
@synthesize viewModel = _viewModel;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    MRCViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    [[viewController
      rac_signalForSelector:@selector(viewDidLoad)]
     subscribeNext:^(id x) {
         @strongify(viewController)
         [viewController bindViewModel];
     }];
    
    return viewController;
}

- (void)configTabBarHiddenWhenPush{
    
    [[self rac_signalForSelector:@selector(viewWillAppear:)]
     subscribeNext:^(id x) {
         self.hidesBottomBarWhenPushed = YES;
     }];
    
    [[self rac_signalForSelector:@selector(viewWillDisappear:)]
     subscribeNext:^(id x) {
         self.hidesBottomBarWhenPushed = NO;
     }];
}

- (id<MRCViewProtocol>)initWithViewModel:(id)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
}

- (void)bindViewModel {
    // System title view
    RAC(self, title) = RACObserve(self.viewModel, title);
    
    UIView *titleView = self.navigationItem.titleView;

    
    // Loading title view
    MRCLoadingTitleView *loadingTitleView = [[NSBundle mainBundle] loadNibNamed:@"MRCLoadingTitleView" owner:nil options:nil].firstObject;
    loadingTitleView.frame = CGRectMake((SCREEN_WIDTH - CGRectGetWidth(loadingTitleView.frame)) / 2.0, 0, CGRectGetWidth(loadingTitleView.frame), CGRectGetHeight(loadingTitleView.frame));
    
    
    
    RAC(self.navigationItem, titleView) = [RACObserve(self.viewModel, titleViewType).distinctUntilChanged map:^(NSNumber *value) {
        MRCTitleViewType titleViewType = value.unsignedIntegerValue;
        switch (titleViewType) {
            case MRCTitleViewTypeDefault:
                return titleView;
            case MRCTitleViewTypeDoubleTitle:
                return titleView;
//                return (UIView *)doubleTitleView;
            case MRCTitleViewTypeLoadingTitle:
                return (UIView *)loadingTitleView;
        }
    }];
    
//    @weakify(self)
//    [self.viewModel.errors subscribeNext:^(NSError *error) {
////        @strongify(self)
//        
//        CJRLogError(error);
//        //主要是要现实网络出错的view
//        //如果有一种情况是登陆出错，直接切换rootviewcontroller
//        
//    
//    }];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.viewModel.willDisappearSignal sendNext:nil];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? UIInterfaceOrientationMaskLandscape : UIInterfaceOrientationMaskPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
