//
//  NewsSubListModel.h
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/3.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import "ModelObject.h"

@interface NewsSubListModel :ModelObject

//@property (nonatomic, strong) NSNumber *infoID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *thumb; //链接

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, copy) NSString *movie_url;

@property (nonatomic, strong) NSString *up;

@property (nonatomic, strong) NSString *comment_num;

@property (nonatomic, strong) NSString *tid;

@property (nonatomic, strong) NSString *is_movie;

@property (nonatomic, copy) NSString *time;

@end
