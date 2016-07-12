//
//  ArticleListRequestModel.h
//  eLegionTestApp
//
//  Created by Nikolay Ischuk on 12.07.16.
//  Copyright © 2016 Nikolay Ischuk. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RepoListRequestModel: JSONModel

@property (nonatomic, copy) NSString *query;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *order;


@end
