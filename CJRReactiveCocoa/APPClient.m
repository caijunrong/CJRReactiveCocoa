//
//  APPClient.m
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/3.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import "APPClient.h"
#import <AFHTTPRequestOperationManager.h>

#import <RACEXTScope.h>

@implementation APPClient

- (id)init{
    if (self = [super init]) {
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager.requestSerializer  willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 20;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        self.manager = manager;
        
    }
    return self;
}


//- (RACSignal *)requestNewsWithSpecialID:(NSInteger)specialID andPageIndex:(NSInteger)pageIndex{
//    
//    return [self  GetRequest:[NSString stringWithFormat:NEWSURL,specialID,pageIndex] parameter:nil completeJSONSerialization:^(id responseObject, NSError *error) {
//        
//    }];
//}

- (RACSignal *)PostRequestJSONSerialization:(NSString *)url parameter:(NSDictionary *)patameter{
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        [self PostRequest:url parameter:patameter complete:^(id responseObject, NSError *error) {
            
            if (!error) {
                
                NSError *jsonError = nil;
                id json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&jsonError];
                if (!jsonError) {
                    // 1 当JSON数据存在并且没有错误，发送给订阅者序列化后的JSON数组或字典。
                    [subscriber sendNext:json];
                }
                else {
                    // 2 在任一情况下如果有一个错误，通知订阅者。
                    [subscriber sendError:jsonError];
                }
                
            }else{
                // 2 在任一情况下如果有一个错误，通知订阅者。
                [subscriber sendError:error];
            }
            
            // 3 无论该请求成功还是失败，通知订阅者请求已经完成。
            [subscriber sendCompleted];
            
        }];
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"PostRequest 信号销毁");
        }];
            
    }];
        
}

- (RACSignal *)GetRequestJSONSerialization:(NSString *)url parameter:(NSDictionary *)patameter{
     @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
         @strongify(self)
        [self GetRequest:url parameter:patameter complete:^(id responseObject, NSError *error) {
            NSLog(@"json:%@",responseObject);
            if (!error) {
                
                NSError *jsonError = nil;
                id json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&jsonError];
                if (!jsonError) {
                    // 1 当JSON数据存在并且没有错误，发送给订阅者序列化后的JSON数组或字典。
                    [subscriber sendNext:json];
                }
                else {
                    // 2 在任一情况下如果有一个错误，通知订阅者。
                    [subscriber sendNext:nil];
                }
                
            }else{
                // 2 在任一情况下如果有一个错误，通知订阅者。
                
                [subscriber sendError:error];
            }
            
            // 3 无论该请求成功还是失败，通知订阅者请求已经完成。
            [subscriber sendCompleted];
            
        }];
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"PostRequest 信号销毁");
        }];
        
    }];
    
}


- (void)PostRequest:(NSString *)url parameter:(NSDictionary *)patameter complete:(CompleteResult)completeBlock{
    
    [self.manager POST:[NSString stringWithFormat:@"%@",url] parameters:patameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {

        if (completeBlock) {
            completeBlock(responseObject,nil);
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"网路请求失败");
        if (completeBlock) {
            completeBlock(nil,error);
        }
    }];
    
    
}

- (void)GetRequest:(NSString *)url parameter:(NSDictionary *)patameter complete:(CompleteResult)completeBlock{
    
    [self.manager GET:[NSString stringWithFormat:@"%@",url] parameters:patameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"url:%@",url);
        NSLog(@"responseObject:%@",responseObject);
        if (completeBlock) {
            completeBlock(responseObject,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"url:%@",url);
        
        NSLog(@"patameter:%@",patameter);
        if (completeBlock) {
            completeBlock(nil,error);
        }
        
    }];
}


@end
