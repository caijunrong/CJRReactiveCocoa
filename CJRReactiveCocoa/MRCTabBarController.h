//
//  MRCTabBarController.h
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/2.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import "MRCViewController.h"
#import "MRCViewProtocol.h"

@interface MRCTabBarController : MRCViewController<UITabBarControllerDelegate>

@property (nonatomic, strong, readonly) UITabBarController *tabBarController;

@end
