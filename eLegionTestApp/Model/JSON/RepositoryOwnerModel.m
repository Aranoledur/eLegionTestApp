//
//  RepositoryOwnerModel.m
//  eLegionTestApp
//
//  Created by Nikolay Ischuk on 12.07.16.
//  Copyright © 2016 Nikolay Ischuk. All rights reserved.
//

#import "RepositoryOwnerModel.h"

@implementation RepositoryOwnerModel

+ (JSONKeyMapper *)keyMapper {    
    return [[JSONKeyMapper alloc] initWithDictionary:@{ @"id": @"_id", @"login": @"login", @"avatar_url": @"avatar_url", @"gravatar_id": @"gravatar_id", @"url": @"url", @"received_events_url": @"received_events_url", @"type": @"type"}];
}

@end
