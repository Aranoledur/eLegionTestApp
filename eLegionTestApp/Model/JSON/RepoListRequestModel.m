//
//  ArticleListRequestModel.m
//  eLegionTestApp
//
//  Created by Nikolay Ischuk on 12.07.16.
//  Copyright © 2016 Nikolay Ischuk. All rights reserved.
//

#import "RepoListRequestModel.h"

@implementation RepoListRequestModel

#pragma mark - JSONModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{ @"q": @"query", @"sort": @"sort", @"order": @"order" }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}


@end
