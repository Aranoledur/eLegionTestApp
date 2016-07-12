//
//  SearchRequest.h
//  eLegionTestApp
//
//  Created by Nikolay Ischuk on 12.07.16.
//  Copyright © 2016 Nikolay Ischuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PHNetworkManager.h"

@interface SearchRequest : NSObject

- (NSURLSessionDataTask *)repositoriesForString:(NSString *)string
                 successBlock:(SuccessBlock)success
                 failureBlock:(FailureBlock)failure;

@end
