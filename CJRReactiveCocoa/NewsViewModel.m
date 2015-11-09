//
//  NewsViewModel.m
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/6.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import "NewsViewModel.h"
#import "APPManager.h"
#import "NewsModel.h"
#import "NewsSubListModel.h"
#import "NewsItemVIewModel.h"
#import "ModelObject.h"

@interface NewsViewModel()

@property (nonatomic, copy, readwrite) NSArray *events;

@property (nonatomic, strong, readwrite) RACCommand *didClickLinkCommand;



@end

@implementation NewsViewModel


- (instancetype)initWithParams:(id)params{
    self = [super initWithParams:params];
    
    if (self) {
        
    }
    return self;
}

- (void)initialize{
    [super initialize];
    
    self.title = @"首页";
    
    self.shouldPullToRefresh = YES;
//    
//    self.didSelectCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
//       
//        NSLog(@"index:%@",indexPath);
//        return [RACSignal empty];
//    }];
//    
//    APPManager *appManager = [[APPManager alloc]init];
//    RACSignal *signal = [[appManager requestNewsWithSpecialID:1 andPageIndex:1 Model:NewsModel.class]
//                         doNext:^(NewsModel *nsModel) {
//                             NSLog(@"nsModel:%@",nsModel);
//                             
//                         }];
//    [signal subscribeNext:^(NewsModel *nsModel) {
//                NSLog(@"nsModel:%@",nsModel);
//    }];
    
//    [self.requestRemoteDataCommand.executing subscribeNext:^(NewsModel *nsModel) {
//        NSLog(@"nsModel++:%@",nsModel);
//    }];
    
    
    //???
//    RAC(self, events) = [self.requestRemoteDataCommand
    
//    [self requestDataWithPage:1];
    
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        
        NewsItemVIewModel *viewModel = self.dataSource[indexPath.section][indexPath.row];
        
        //alloc init viewmodel 然后new一个viewcontroller push过去
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"抬头" message:viewModel.event.title delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
//        [alert show];
        NSLog(@"summ:%@",viewModel.event.summary);
        
        return [RACSignal empty];
    }];
    
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    RACSignal *signal = [self.appManager requestNewsWithSpecialID:1 andPageIndex:page Model:NewsModel.class];
    @weakify(self);
    [signal  subscribeNext:^(NewsModel *newsModel) {
        @strongify(self);
        if (!newsModel || newsModel.count == 0) {
            NSLog(@"request error");//转不了model，或者出了问题或者为空白
            self.requestError = @"Empty";
        }else{
            //没问题，可以进行操作
            self.events = newsModel.listArray;
        }
    }error:^(NSError *error) {
        @strongify(self);
        //网络访问失败
        self.requestError = @"Error";
    } completed:^{
//        self.isRequestFinished = @(YES);
    }];
    
    
    return signal;
    
}

- (RACSignal *)requestDataWithPage:(NSUInteger )page{
    
    RACSignal *signal = [self.appManager requestNewsWithSpecialID:1 andPageIndex:page Model:NewsModel.class];
    @weakify(self);
    [signal  subscribeNext:^(NewsModel *newsModel) {
        @strongify(self);
        if (!newsModel || newsModel.count == 0) {
            NSLog(@"request error");//转不了model，或者出了问题或者为空白
            self.requestError = @"Empty";
        }else{
            //没问题，可以进行操作
            self.events = newsModel.listArray;
        }
    }error:^(NSError *error) {
        @strongify(self);
        //网络访问失败
        self.requestError = @"Error";
    } completed:^{
        self.isRequestFinished = @(YES);
    }];
    
    
    return signal;
    
}



- (BOOL (^)(NSError *))requestRemoteDataErrorsFilter {
    return ^BOOL(NSError *error) {
        if (error != nil) {
            CJRLogError(error);
            return NO;
        }
        return YES;
    };
}

- (id)fetchLocalData {
    NSArray *events = nil;
//
//    if (self.isCurrentUser) {
//        if (self.type == MRCNewsViewModelTypeNews) {
//            events = [OCTEvent mrc_fetchUserReceivedEvents];
//        } else if (self.type == MRCNewsViewModelTypePublicActivity) {
//            events = [OCTEvent mrc_fetchUserPerformedEvents];
//        }
//    }
//    
    return events;
}



- (NSArray *)dataSourceWithEvents:(NSArray *)eventst{
    if (eventst.count == 0) {
        return nil;
    }
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    for (NewsSubListModel *subModel in eventst) {
        NewsItemVIewModel *viewModel = [[NewsItemVIewModel alloc]initWithEvent:subModel];
        [arr addObject:viewModel];
    }
    return @[arr];
    
//    NSArray *viewModels = [eventst.rac_sequence map:^id(ModelObject *even) {
//        NewsItemVIewModel *viewModel = [[NewsItemVIewModel alloc]initWithEvent:even];
//        return viewModel;
//    }].array;
//
//    return viewModels;
}

@end
