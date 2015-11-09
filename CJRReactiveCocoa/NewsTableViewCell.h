//
//  NewsTableViewCell.h
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/6.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsItemVIewModel.h"

@interface NewsTableViewCell : UITableViewCell

+ (CGFloat)heightWithViewModel:(NewsItemVIewModel *)viewModel;

@end
