//
//  NewsViewModel.h
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/6.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import "MRCTableViewModel.h"

@interface NewsViewModel : MRCTableViewModel

@property (nonatomic, copy, readonly) NSArray *events;

@property (nonatomic, strong, readonly) RACCommand *didClickLinkCommand;

- (NSArray *)dataSourceWithEvents:(NSArray *)events;

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page;

@end
