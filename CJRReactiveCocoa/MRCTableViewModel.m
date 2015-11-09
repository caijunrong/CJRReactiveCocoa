//
//  MRCTableViewModel.m
//  CJRReactiveCocoa
//
//  Created by biyabi on 15/11/9.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import "MRCTableViewModel.h"

@interface MRCTableViewModel()

@property (nonatomic, strong, readwrite) RACCommand *requestRemoteDataCommand;


@end

@implementation MRCTableViewModel

- (void)initialize {
    [super initialize];
    
    self.page = 1;
    
    @weakify(self)
    self.requestRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *page) {
        @strongify(self)
        return [[self requestRemoteDataSignalWithPage:page.unsignedIntegerValue] takeUntil:self.rac_willDeallocSignal];
    }];
    
}

- (RACSignal *)requestDataWithPage:(NSUInteger )page{
    return [RACSignal empty];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    return [RACSignal empty];
}

@end
