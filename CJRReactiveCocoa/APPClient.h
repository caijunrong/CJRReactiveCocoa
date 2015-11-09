//
//  APPClient.h
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/3.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectInterface.h"

typedef void (^CompleteResult)(id responseObject ,NSError *error );

@class AFHTTPRequestOperationManager;

@interface APPClient : NSObject

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

- (void)PostRequest:(NSString *)url parameter:(NSDictionary *)patameter complete:(CompleteResult)completeBlock;

- (void)GetRequest:(NSString *)url parameter:(NSDictionary *)patameter complete:(CompleteResult)completeBlock;

- (RACSignal *)PostRequestJSONSerialization:(NSString *)url parameter:(NSDictionary *)patameter;

- (RACSignal *)GetRequestJSONSerialization:(NSString *)url parameter:(NSDictionary *)patameter;

@end
