//
//  NewsModel.m
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/3.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import "NewsModel.h"
#import "NewsSubListModel.h"

@implementation NewsModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{

    return @{@"pageDictionary":@"page",
             @"listArray":@"list",
             @"status":@"status",
             @"numberOfPage":@"page.Page",
             @"count":@"page.Count",
             @"pageCount":@"page.PageCount"
             };
}

+ (NSValueTransformer *)listArrayJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [MTLJSONAdapter modelsOfClass:[NewsSubListModel class] fromJSONArray:value error:nil];
        
    }];
}

@end
