//
//  MRCTableViewController.m
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/5.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import "MRCTableViewController.h"
#import "MRCTableViewModel.h"
#import "MRCTableViewCellStyleValue1.h"

@interface MRCTableViewController ()

@property (nonatomic, weak, readwrite) IBOutlet UITableView *tableView;

@property (nonatomic, strong, readonly) MRCTableViewModel *viewModel;

@end

@implementation MRCTableViewController

@dynamic viewModel;

- (instancetype)initWithViewModel:(id<MRCViewModelProtocol>)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
//        if ([viewModel shouldRequestRemoteDataOnViewDidLoad]) {
//            @weakify(self)
//            [[self rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
//                @strongify(self)
//                [self.viewModel.requestRemoteDataCommand execute:@1];
//            }];
//        }
    }
    return self;
}

- (void)setView:(UIView *)view {
    [super setView:view];
    if ([view isKindOfClass:UITableView.class]) self.tableView = (UITableView *)view;
}

- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerClass:[MRCTableViewCellStyleValue1 class] forCellReuseIdentifier:@"MRCTableViewCellStyleValue1"];
    
    self.tableView.tableFooterView = [[UIView alloc] init];

    
    if (self.viewModel.shouldPullToRefresh) {
        
        @weakify(self)
        
        
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
//            [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = @"Loading...";
            self.viewModel.page = 1;
            
            [[self.viewModel.requestRemoteDataCommand execute:@(self.viewModel.page)] subscribeNext:^(id x) {
                
            }error:^(NSError *error) {
                
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                
            } completed:^{
                [self refreshComplete];
            }];
            
            
        }];
        
        self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            @strongify(self)
            
//            [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = @"Loading...";
            self.viewModel.page ++;
            
            [[self.viewModel.requestRemoteDataCommand execute:@(self.viewModel.page)] subscribeNext:^(id x) {
                
            }error:^(NSError *error) {
                
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                
            } completed:^{
                [self refreshComplete];
                
            }];
            
            
        }];
        
        [self.tableView.mj_header beginRefreshing];
    }else{
        
        //普通网络请求
        
        [[self.viewModel.requestRemoteDataCommand execute:@(self.viewModel.page)] subscribeNext:^(id x) {
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = @"Loading...";
            
        }completed:^{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            [self.tableView reloadData];
            
        }];
        
        
    }
    
    
    
}

- (void)refreshComplete{
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

- (void)dealloc {
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
}

- (void)bindViewModel {
    [super bindViewModel];
    
    @weakify(self)
    [RACObserve(self.viewModel, dataSource).distinctUntilChanged.deliverOnMainThread subscribeNext:^(id x) {
        @strongify(self)
        NSLog(@"self.tableView:%@",self.tableView);
        
        [self.tableView reloadData];
    }];
    
//    [self.viewModel.requestRemoteDataCommand.executing subscribeNext:^(NSNumber *executing) {
//        @strongify(self)
//        UIView *emptyDataSetView = [self.tableView.subviews.rac_sequence objectPassingTest:^(UIView *view) {
//            return [NSStringFromClass(view.class) isEqualToString:@"DZNEmptyDataSetView"];
//        }];
//        emptyDataSetView.alpha = 1.0 - executing.floatValue;
//        NSLog(@"self.viewModel.requestRemoteDataCommand.executing");
//    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"%d",[self.viewModel.dataSource count]);
    return self.viewModel.dataSource ? self.viewModel.dataSource.count : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"MRCTableViewCellStyleValue1" forIndexPath:indexPath];
    
    id object = self.viewModel.dataSource[indexPath.section][indexPath.row];
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return nil;
//    if (section >= self.viewModel.sectionIndexTitles.count) return nil;
//    return self.viewModel.sectionIndexTitles[section];
//}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    return self.viewModel.sectionIndexTitles;
//}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.viewModel.didSelectCommand execute:indexPath];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
