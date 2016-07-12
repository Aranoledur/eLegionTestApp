//
//  MainViewController.m
//  eLegionTestApp
//
//  Created by Nikolay Ischuk on 12.07.16.
//  Copyright © 2016 Nikolay Ischuk. All rights reserved.
//

#import "MainViewController.h"
#import "RepositoryTableViewCell.h"

#import "RepositoryModel.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [RepositoryModel printKeyMapper];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
