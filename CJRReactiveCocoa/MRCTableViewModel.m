//
//  MRCTableViewModel.m
//  CJRReactiveCocoa
//
//  Created by biyabi on 15/11/9.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import "MRCTableViewModel.h"

@implementation MRCTableViewModel

- (void)initialize {
    [super initialize];
    
    self.page = 1;
}

- (RACSignal *)requestDataWithPage:(NSUInteger )page{
    return [RACSignal empty];
}


@end
