//
//  APPManager.m
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/4.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import "APPManager.h"
#import <Mantle.h>

@implementation APPManager

- (id)init{
    if (self = [super init]) {
        
    }
    return self;
}




- (RACSignal *)requestNewsWithSpecialID:(NSInteger)specialID andPageIndex:(NSInteger)pageIndex Model:(Class)model{

    return [[self GetRequestJSONSerialization:[NSString stringWithFormat:NEWSURL,specialID,pageIndex] parameter:nil]
        map:^id(NSDictionary *json) {
            
            return [MTLJSONAdapter modelOfClass:model fromJSONDictionary:json error:nil];
            
        }];
    
}

- (RACSignal *)fetchModelForPostMoehod:(NSString *)url parameter:(NSDictionary *)parameter Model:(Class)modelClass{
    
    return [[self PostRequestJSONSerialization:url parameter:parameter]
            map:^id(id value) {
                if ([value isKindOfClass:NSArray.class]) {
                    return [MTLJSONAdapter modelsOfClass:modelClass fromJSONArray:value error:nil];
                }else if([value isKindOfClass:NSDictionary.class]){
                    return [MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:value error:nil];
                }else{
                    return value;
                }
            }];
    
}

- (RACSignal *)fetchModelForGetMoehod:(NSString *)url parameter:(NSDictionary *)parameter Model:(Class)modelClass{
    
    return [[self GetRequestJSONSerialization:url parameter:parameter]
        map:^id(id value) {
            if ([value isKindOfClass:NSArray.class]) {
                return [MTLJSONAdapter modelsOfClass:modelClass fromJSONArray:value error:nil];
            }else if([value isKindOfClass:NSDictionary.class]){
                return [MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:value error:nil];
            }else{
                return value;
            }
        }];
    
}

@end
