//
//  SearchRequest.m
//  eLegionTestApp
//
//  Created by Nikolay Ischuk on 12.07.16.
//  Copyright © 2016 Nikolay Ischuk. All rights reserved.
//

#import "SearchRequest.h"

@implementation SearchRequest

- (NSURLSessionDataTask *)repositoriesForString:(NSString *)string successBlock:(SuccessBlock)success failureBlock:(FailureBlock)failure {
    NSDictionary *params = @{@"q": string};
    
    return [[PHNetworkManager sharedInstance] sendRequestWithType:RequestTypeGet byURL:kSearchRepositoriesURL withParams:params withSuccessBlock:success andFailureBlock:failure];
}

@end
