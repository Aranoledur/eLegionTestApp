//
//  SearchTableViewController.m
//  eLegionTestApp
//
//  Created by Nikolay Ischuk on 12.07.16.
//  Copyright © 2016 Nikolay Ischuk. All rights reserved.
//

#import "SearchTableViewController.h"
#import "RepositoryTableViewCell.h"
#import "SearchRequest.h"
#import "Repository.h"
#import "RepositoryModel.h"
#import "DatabaseManager.h"
#import <AFNetworking/AFNetworking.h>

@interface SearchTableViewController ()<UISearchResultsUpdating, UISearchBarDelegate>

@property (strong, nonatomic) NSURLSessionDataTask *searchSessionTask;
@property (strong, nonatomic) NSArray<RepositoryModel *> *searchResult;
@property (strong, nonatomic) UISearchController *searchController;

@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"RepositoryTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:NSStringFromClass([RepositoryTableViewCell class])];
    self.tableView.rowHeight = 63;
    self.tableView.allowsMultipleSelection = YES;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.searchController.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.title = @"Search";
    
}

#pragma mark - Table view data source

- (RepositoryModel *)itemForIndexPath:(NSIndexPath *)path {
    if (path.row < self.searchResult.count) {
        return self.searchResult[path.row];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResult.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RepositoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RepositoryTableViewCell class]) forIndexPath:indexPath];
    RepositoryModel *data = [self itemForIndexPath:indexPath];
    if (data) {
        [cell setupWithRepoModel:data];
    }
    if ([[DatabaseManager sharedInstance] repositoryExistsWithID:data._id]) {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RepositoryModel *model = [self itemForIndexPath:indexPath];
    if (model != nil) {
        [[DatabaseManager sharedInstance] addOrUpdateRepoWithModel:model];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    RepositoryModel *model = [self itemForIndexPath:indexPath];
    if (model != nil) {
        [[DatabaseManager sharedInstance] deleteRepoByID:model._id];
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self.searchSessionTask cancel];
    SearchRequest *searchRequest = [[SearchRequest alloc] init];
    self.searchSessionTask = [searchRequest repositoriesForString:searchBar.text successBlock:^(NSURLSessionTask *task, id responseObject) {

        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDictionary = responseObject;
            NSArray *items = responseDictionary[@"items"];
            if ([items isKindOfClass:[NSArray class]] && ([[items lastObject] isKindOfClass:[NSDictionary class]])) {
                NSMutableArray *repos = [NSMutableArray arrayWithCapacity:items.count];
                for (NSDictionary *item in items) {
                    NSError *error;
                    RepositoryModel *repo = [[RepositoryModel alloc] initWithDictionary:item error:&error];
                    if (error == nil) {
                        [repos addObject:repo];
                    }
                }
                
                self.searchResult = [NSArray arrayWithArray:repos];
                [self.tableView reloadData];
            }
        }
    } failureBlock:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}

@end
