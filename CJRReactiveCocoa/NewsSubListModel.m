//
//  NewsSubListModel.m
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/3.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import "NewsSubListModel.h"

@implementation NewsSubListModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{ @"title":@"title",
              @"thumb":@"thumb",
              @"summary":@"summary",
              @"movie_url":@"movie_url",
              @"up":@"up",
              @"comment_num":@"comment_num",
              @"tid":@"tid",
              @"is_movie":@"is_movie",
              @"time":@"time"
              };
}
@end
