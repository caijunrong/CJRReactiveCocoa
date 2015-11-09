//
//  NewsTableViewCell.m
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/6.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import "NewsTableViewCell.h"

@interface NewsItemVIewModel()

@end

@implementation NewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindViewModel:(NewsItemVIewModel *)viewModel{
    [self.imageVIew sd_setImageWithURL:[NSURL URLWithString:viewModel.event.thumb]];
    [self.TitleLabel setText:viewModel.event.title];

}

+ (CGFloat)heightWithViewModel:(NewsItemVIewModel *)viewModel{
    
    NSLog(@"Cell .s viewModel:%@",viewModel);
    
    return 90;
}

@end
