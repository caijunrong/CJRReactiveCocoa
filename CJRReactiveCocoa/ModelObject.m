//
//  ModelObject.m
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/3.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import "ModelObject.h"

@implementation ModelObject

#pragma mark MTLModel

- (instancetype)init {
    self = [super init];
    if (self == nil) return nil;
    
    
    return self;
}

+ (NSUInteger)modelVersion {
    return 5;
}

+ (NSDictionary *)dictionaryValueFromArchivedExternalRepresentation:(NSDictionary *)externalRepresentation version:(NSUInteger)fromVersion {
    id objectID = externalRepresentation[@"id"];
    if (objectID == nil) return nil;
    
    return @{ @"objectID": objectID };
}

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"objectID": @"id"
             };
}

+ (NSValueTransformer *)objectIDJSONTransformer {
    return [MTLValueTransformer
            reversibleTransformerWithForwardBlock:^(NSNumber *num) {
                return num.stringValue;
            } reverseBlock:^ id (NSString *str) {
                if (str == nil) return nil;
                
                return [NSDecimalNumber decimalNumberWithString:str];
            }];
}

- (BOOL)validateObjectID:(id *)objectID error:(NSError **)error {
    if ([*objectID isKindOfClass:NSString.class]) {
        return YES;
    } else if ([*objectID isKindOfClass:NSNumber.class]) {
        *objectID = [*objectID stringValue];
        return YES;
    }
    
    return *objectID == nil;
}

- (BOOL)isEqual:(ModelObject *)obj{
    if (self == obj) {
        return YES;
    }

    if ([obj isMemberOfClass:self.class]) {
        return NO;
    }
    
    return [obj.objectID isEqual:self.objectID];
}


@end
