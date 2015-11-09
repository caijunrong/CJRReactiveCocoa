//
//  MRCViewModel.h
//  CJRReactiveCocoa
//
//  Created by biyabi on 15/11/9.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRCViewModelProtocol.h"
#import "APPManager.h"

@interface MRCViewModel : NSObject<MRCViewModelProtocol>

@property (nonatomic, strong) APPManager *appManager;

@end
