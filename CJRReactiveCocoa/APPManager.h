//
//  APPManager.h
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/4.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APPClient.h"

@interface APPManager :APPClient
- (RACSignal *)requestNewsWithSpecialID:(NSInteger)specialID andPageIndex:(NSInteger)pageIndex Model:(Class)model;
- (RACSignal *)fetchModelForPostMoehod:(NSString *)url parameter:(NSDictionary *)parameter Model:(Class)modelClass;
- (RACSignal *)fetchModelForGetMoehod:(NSString *)url parameter:(NSDictionary *)parameter Model:(Class)modelClass;


@end
