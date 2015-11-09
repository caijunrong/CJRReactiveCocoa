//
//  ModelObject.h
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/3.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle.h>

@interface ModelObject : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *objectID;


@end
