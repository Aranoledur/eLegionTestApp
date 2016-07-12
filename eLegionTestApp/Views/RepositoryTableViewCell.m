//
//  RepositoryTableViewCell.m
//  eLegionTestApp
//
//  Created by Nikolay Ischuk on 12.07.16.
//  Copyright © 2016 Nikolay Ischuk. All rights reserved.
//

#import "RepositoryTableViewCell.h"
#import "RepositoryModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface RepositoryTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectionImageView;

@end

@implementation RepositoryTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    UIImage *selectionImage = [UIImage imageNamed: selected ? @"subButtonComplete" : @"subButtonAdd"];
    self.selectionImageView.image = selectionImage;
}

- (void)setupWithRepo:(RepositoryModel *)repo {
    self.nameLabel.text = repo.name;
    [self.avatarImageView setShowActivityIndicatorView:YES];
    [self.avatarImageView setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:repo.owner.avatar_url]];
}

@end
