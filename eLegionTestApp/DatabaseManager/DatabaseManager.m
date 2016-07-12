//
//  DatabaseManager.m
//  eLegionTestApp
//
//  Created by Nikolay Ischuk on 12.07.16.
//  Copyright © 2016 Nikolay Ischuk. All rights reserved.
//

#import "DatabaseManager.h"
#import "Repository.h"
#import "RepositoryModel.h"

@implementation DatabaseManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t pred;
    static id shared = nil;
    dispatch_once(&pred, ^{
        shared = [[super alloc] init];
    });
    
    return shared;
}

- (BOOL)repositoryExistsWithID:(NSInteger)ID {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"_id = %lu", ID];
    RLMResults *fetchResult = [Repository objectsWithPredicate:pred];
    return fetchResult.count > 0;
}

- (Repository *)repoByID:(NSInteger)ID {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"_id = %lu", ID];
    RLMResults *fetchResult = [Repository objectsWithPredicate:pred];
    return [fetchResult lastObject];
}

- (void)addOrUpdateRepoWithModel:(RepositoryModel *)model {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    Repository *repoInDatabase = [[Repository alloc] initWithModel:model];
    [realm addOrUpdateObject:repoInDatabase];
    [realm commitWriteTransaction];
}

- (void)deleteRepoByID:(NSInteger)ID {
    Repository *repoInBase = [self repoByID:ID];
    if (repoInBase != nil) {
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm deleteObject:repoInBase];
        [realm commitWriteTransaction];
    }
}

- (NSArray *)allRepos {
    RLMResults<Repository *> *reposResult = [Repository allObjects];
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:reposResult.count];
    for (Repository *repo in reposResult) {
        [array addObject:repo];
    }
    return [array copy];
}

@end
