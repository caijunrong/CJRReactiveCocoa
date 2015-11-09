//
//  MRCTableViewModel.h
//  CJRReactiveCocoa
//
//  Created by biyabi on 15/11/9.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import "MRCViewModel.h"

@interface MRCTableViewModel : MRCViewModel

@property (nonatomic, copy) NSArray *dataSource;

@property (nonatomic, assign) NSUInteger page;

@property (nonatomic, strong) NSString *requestError;

@property (nonatomic, strong) NSNumber *isRequestFinished;

@property (nonatomic, assign) BOOL shouldPullToRefresh;

- (RACSignal *)requestDataWithPage:(NSUInteger )page;

@end
