//
//  MyNewsViewController.m
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/6.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import "MyNewsViewController.h"
#import "NewsModel.h"
#import "NewsItemVIewModel.h"
#import "NewsSubListModel.h"
#import "NewsViewModel.h"
#import "NewsTableViewCell.h"
#import "NewsItemVIewModel.h"

@interface MyNewsViewController ()

@property (nonatomic, strong, readonly) NewsViewModel *viewModel;

@end

@implementation MyNewsViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setContentInset:self.contentInset];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsTableViewCell"];
    
    
    
    @weakify(self)
    RAC(self.viewModel, dataSource) = [[RACObserve(self.viewModel, events)
                                        map:^(NSArray *events) {
                                            
                                            @strongify(self)
                                            return [self.viewModel dataSourceWithEvents:events];
                                        }]
                                       map:^(NSArray *viewModels) {
                                           for (NewsItemVIewModel *viewModel in viewModels.firstObject) {
                                               viewModel.height = [NewsTableViewCell heightWithViewModel:viewModel];
                                           }
                                           if (self.viewModel.page != 1) {
                                               NSMutableArray *array = [[NSMutableArray alloc]initWithArray:self.viewModel.dataSource];
                                               [array addObjectsFromArray:viewModels];
                                               NSArray *arr = array;
                                               return arr;
                                           }else{
                                               return viewModels;
                                           }
                                           
                                           
                                       }];

    [[RACObserve(self.viewModel, requestError) deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSString *value) {
        if ([value isEqualToString:@"Empty"] && self.viewModel.page == 1) {
            //刷新为空，@“什么都没有”
            
            
        }else if([value isEqualToString:@"Empty"] && self.viewModel.page != 1){
            //加载更多为空
            
        }else if([value isEqualToString:@"Error"]){
            //网络加载失败,提示
//            [self.progressHUB showMessage:@"网络加载失败，请检查网络连接" duration:1.2f];
            NSLog(@"网络加载失败");
        }
        
        
    }];
    
    
}

-(void)bindViewModel{
    [super bindViewModel];
    
    
}


- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsMake(64, 0, 64, 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"NewsTableViewCell" forIndexPath:indexPath];
}

- (void)configureCell:(NewsTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(NewsItemVIewModel *)viewModel {
    [cell bindViewModel:viewModel];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel.dataSource[indexPath.section][indexPath.row] height];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
