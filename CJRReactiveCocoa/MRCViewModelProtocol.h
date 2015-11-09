//
//  MRCViewModelProtocol.h
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/2.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MRCTitleViewType) {
    MRCTitleViewTypeDefault,
    MRCTitleViewTypeDoubleTitle,
    MRCTitleViewTypeLoadingTitle
};


@protocol MRCViewModelProtocol <NSObject>


@required

// Initialization method. This is the preferred way to create a new viewModel.
//
// services - The service bus of Model layer.
// params   - The parameters to be passed to view model.
//
// Returns a new view model.
- (instancetype)initWithParams:(id)params;


// The `params` parameter in `-initWithServices:params:` method.
@property (nonatomic, strong, readonly) id params;

@optional

@property (nonatomic, assign) MRCTitleViewType titleViewType;

@property (nonatomic, copy) NSString *title;

// The callback block.
@property (nonatomic, copy) VoidBlock_id callback;

// A RACSubject object, which representing all errors occurred in view model.
@property (nonatomic, strong, readonly) RACSubject *errors;


@property (nonatomic, strong, readonly) RACSubject *willDisappearSignal;

// An additional method, in which you can initialize data, RACCommand etc.
//
// This method will be execute after the execution of `-initWithServices:params:` method. But
// the premise is that you need to inherit `MRCViewModel`.
- (void)initialize;


@end
