//
//  RepositoryTableViewCell.h
//  eLegionTestApp
//
//  Created by Nikolay Ischuk on 12.07.16.
//  Copyright © 2016 Nikolay Ischuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RepositoryModel;
@interface RepositoryTableViewCell : UITableViewCell

- (void)setupWithRepo:(RepositoryModel *)repo;

@end
