//
//  RepositoryOwnerModel.h
//  eLegionTestApp
//
//  Created by Nikolay Ischuk on 12.07.16.
//  Copyright © 2016 Nikolay Ischuk. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RepositoryOwnerModel : JSONModel

@property NSInteger _id;
@property NSString *login;
@property NSString *avatar_url;
@property NSString *gravatar_id;
@property NSString *url;
@property NSString *received_events_url;
@property NSString *type;

@end
