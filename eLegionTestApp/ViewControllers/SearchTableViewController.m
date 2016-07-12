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
#import <AFNetworking/AFNetworking.h>

@interface SearchTableViewController ()<UISearchResultsUpdating, UISearchBarDelegate>

@property (strong, nonatomic) NSURLSessionDataTask *searchSessionTask;
@property (strong, nonatomic) NSMutableArray *searchResult;
@property (strong, nonatomic) UISearchController *searchController;

@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"RepositoryTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:NSStringFromClass([RepositoryTableViewCell class])];
    self.tableView.rowHeight = 63;
    
    UITableViewController *searchResultsController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    searchResultsController.tableView.delegate = self;
    searchResultsController.tableView.dataSource = self;
    searchResultsController.tableView.rowHeight = 63;
    [searchResultsController.tableView registerNib:cellNib forCellReuseIdentifier:NSStringFromClass([RepositoryTableViewCell class])];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.searchController.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResult.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RepositoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RepositoryTableViewCell class]) forIndexPath:indexPath];
    
    
    return cell;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self.searchSessionTask cancel];
    SearchRequest *searchRequest = [[SearchRequest alloc] init];
    self.searchSessionTask = [searchRequest repositoriesForString:searchBar.text successBlock:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"%@ %@", task, responseObject);
    } failureBlock:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}

@end
