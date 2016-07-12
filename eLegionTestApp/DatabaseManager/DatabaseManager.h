//
//  DatabaseManager.h
//  eLegionTestApp
//
//  Created by Nikolay Ischuk on 12.07.16.
//  Copyright © 2016 Nikolay Ischuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RepositoryModel;
@interface DatabaseManager : NSObject

+ (instancetype)sharedInstance;

- (BOOL)repositoryExistsWithID:(NSInteger)ID;
- (void)addOrUpdateRepoWithModel:(RepositoryModel *)model;
- (void)deleteRepoByID:(NSInteger)ID;
- (NSArray *)allRepos;

@end
