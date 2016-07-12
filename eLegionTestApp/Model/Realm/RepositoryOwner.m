//
//  RepositoryOwner.m
//  eLegionTestApp
//
//  Created by Nikolay Ischuk on 12.07.16.
//  Copyright © 2016 Nikolay Ischuk. All rights reserved.
//

#import "RepositoryOwner.h"
#import "RepositoryOwnerModel.h"

@implementation RepositoryOwner

+ (NSString *)primaryKey {
    return @"_id";
}

- (instancetype)initWithModel:(RepositoryOwnerModel *)model {
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
