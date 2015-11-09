//
//  NewsItemVIewModel.h
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/6.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsSubListModel.h"

@interface NewsItemVIewModel : NSObject

@property (nonatomic, strong, readonly) NewsSubListModel *event;

@property (nonatomic, assign) CGFloat height;

- (instancetype)initWithEvent:(NewsSubListModel *)event;


@end
