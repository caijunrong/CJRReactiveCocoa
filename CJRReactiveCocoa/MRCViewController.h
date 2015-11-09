//
//  MRCViewController.h
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/2.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRCViewProtocol.h"

@interface MRCViewController : UIViewController<MRCViewProtocol>

- (void)configTabBarHiddenWhenPush;

@end
