//
//  NewsItemVIewModel.m
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/6.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import "NewsItemVIewModel.h"
#import "NewsSubListModel.h"

@interface NewsItemVIewModel()
@property (nonatomic, strong, readwrite) NewsSubListModel *event;

@end

@implementation NewsItemVIewModel
- (instancetype)initWithEvent:(NewsSubListModel *)event {
    self = [super init];
    if (self) {
        self.event = event;
        self.height = 50;
    }
    return self;
}
@end
