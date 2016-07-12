//
//  RepositoryModel.h
//  eLegionTestApp
//
//  Created by Nikolay Ischuk on 12.07.16.
//  Copyright © 2016 Nikolay Ischuk. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "RepositoryOwnerModel.h"

@interface RepositoryModel : JSONModel

@property NSInteger _id;
@property NSString *name;
@property NSString *fullName;
@property RepositoryOwnerModel *owner;
@property BOOL _private;
@property NSString *html_url;
@property NSString *_description;
@property BOOL fork;
@property NSString *url;
@property NSDate *created_at;
@property NSDate *updated_at;
@property NSDate *pushed_at;
@property NSString *homepage;
@property NSInteger size;
@property NSInteger stargazers_count;
@property NSInteger watchers_count;
@property NSString *language;
@property NSInteger forks_count;
@property NSInteger open_issues_count;
@property NSString *master_branch;
@property NSString *default_branch;
@property NSInteger score;

+ (void)printKeyMapper;

@end
