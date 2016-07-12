//
//  Repository.m
//  eLegionTestApp
//
//  Created by Nikolay Ischuk on 12.07.16.
//  Copyright © 2016 Nikolay Ischuk. All rights reserved.
//

#import "Repository.h"
#import "RepositoryModel.h"

@implementation Repository

+ (NSString *)primaryKey {
    return @"_id";
}

+ (NSDictionary *)keyMapper
{
    return @{ @"id": @"_id", @"private": @"_private", @"description": @"_description" };
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    NSDictionary *keyMapper = [Repository keyMapper];
    for (RLMProperty *prop in self.objectSchema.properties) {
        NSString *propName = prop.name;
        if ([dict objectForKey:propName]) {
            
            if ([keyMapper objectForKey:propName]) {
                [self setValue:dict[propName] forKey:keyMapper[propName]];
            } else {
                [self setValue:dict[propName] forKey:propName];
            }
        }
    }
    
    return self;
}

- (instancetype)initWithModel:(RepositoryModel *)model {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    for (RLMProperty *prop in self.objectSchema.properties) {
        NSString *propName = prop.name;
        id value = [model valueForKey:propName];
        if (value != nil) {
            [self setValue:value forKey:propName];
        }
    }
    
    return self;
}

@end
