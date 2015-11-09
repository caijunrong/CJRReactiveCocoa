//
//  MRCTableViewController.h
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/5.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import "MRCViewController.h"

@interface MRCTableViewController : MRCViewController<UITableViewDataSource, UITableViewDelegate>

// The table view for tableView controller.
@property (nonatomic, weak, readonly) UITableView *tableView;
@property (nonatomic, assign, readonly) UIEdgeInsets contentInset;

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;
@end
