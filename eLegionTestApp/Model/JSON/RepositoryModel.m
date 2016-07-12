//
//  RepositoryModel.m
//  eLegionTestApp
//
//  Created by Nikolay Ischuk on 12.07.16.
//  Copyright © 2016 Nikolay Ischuk. All rights reserved.
//

#import "RepositoryModel.h"

@import ObjectiveC.runtime;

@implementation RepositoryModel

#pragma mark - JSONModel

+ (JSONKeyMapper *)keyMapper {
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{ @"id": @"_id",  @"name": @"name",  @"fullName": @"fullName",  @"owner": @"owner",  @"private": @"_private",  @"html_url": @"html_url",  @"_description": @"description",  @"fork": @"fork",  @"url": @"url",  @"created_at": @"created_at",  @"updated_at": @"updated_at",  @"pushed_at": @"pushed_at",  @"homepage": @"homepage",  @"size": @"size",  @"stargazers_count": @"stargazers_count",  @"watchers_count": @"watchers_count",  @"language": @"language",  @"forks_count": @"forks_count",  @"open_issues_count": @"open_issues_count",  @"master_branch": @"master_branch",  @"default_branch": @"default_branch",  @"score": @"score" }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

+ (void)printKeyMapper {
    unsigned int propertyCount = 0;
    objc_property_t * properties = class_copyPropertyList([self class], &propertyCount);
    
    NSMutableArray * propertyNames = [NSMutableArray array];
    for (unsigned int i = 0; i < propertyCount; ++i) {
        objc_property_t property = properties[i];
        const char * name = property_getName(property);
        [propertyNames addObject:[NSString stringWithUTF8String:name]];
    }
    free(properties);
    
    NSMutableString *string = [NSMutableString new];
    [string appendString:@"{"];
    for (NSString *propName in propertyNames) {
        [string appendString:[NSString stringWithFormat:@" @\"%@\": @\"%@\", ", propName, propName]];
    }
    [string appendString:@"}"];
    NSLog(@"%@", string);
}

@end
