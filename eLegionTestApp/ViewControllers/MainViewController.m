//
//  MainViewController.m
//  eLegionTestApp
//
//  Created by Nikolay Ischuk on 12.07.16.
//  Copyright © 2016 Nikolay Ischuk. All rights reserved.
//

#import "MainViewController.h"
#import "RepositoryTableViewCell.h"
#import "Repository.h"
#import "RepositoryModel.h"
#import "DatabaseManager.h"

@interface MainViewController ()

@property (strong, nonatomic) RLMResults<Repository *> *repos;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"RepositoryTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:NSStringFromClass([RepositoryTableViewCell class])];
    self.tableView.rowHeight = 63;
    self.tableView.allowsSelection = NO;
    self.title = @"Repositories";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.repos = [Repository allObjects];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (Repository *)itemForIndexPath:(NSIndexPath *)path {
    if (path.row < self.repos.count) {
        return self.repos[path.row];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RepositoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RepositoryTableViewCell class]) forIndexPath:indexPath];
    Repository *data = [self itemForIndexPath:indexPath];
    if (data) {
        [cell setupWithRepository:data];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    Repository *data = [self itemForIndexPath:indexPath];
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete:
            [[DatabaseManager sharedInstance] deleteRepoByID:data._id];
            self.repos = [Repository allObjects];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        default:
            break;
    }
}

@end
