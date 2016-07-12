//
//  NetworkManager.m
//  Posh
//
//  Created by Nikita on 18.01.16.
//  Copyright © 2016 Nikita Popov. All rights reserved.
//

#import "PHNetworkManager.h"
#import <AFNetworking/AFNetworking.h>


@interface PHNetworkManager()

@property (strong, nonatomic) AFHTTPSessionManager* manager;

@end

@implementation PHNetworkManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t pred;
    static id shared = nil;
    dispatch_once(&pred, ^{
        shared = [[super alloc] init];
    });
    
    return shared;
}

- (instancetype)init
{
    self = [super init];
    
    if( self )
    {
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURLString]];
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    return self;
}

- (NSURLSessionDataTask *)sendRequestWithType:(RequestType)type
                      byURL:(NSString*)url
                 withParams:(NSDictionary*)params
           withSuccessBlock:(SuccessBlock)successBlock
            andFailureBlock:(FailureBlock)failureBlock
{
    switch (type)
    {
        case RequestTypeGet:
        {
            return [self sendGetRequestByURL:url
                           withParams:params
                     withSuccessBlock:successBlock
                         failureBlock:failureBlock];
            break;
        }
            
        case RequestTypePost:
        {
            return [self sendPostRequestByURL:url
                            withParams:params
                      withSuccessBlock:successBlock
                          failureBlock:failureBlock];
            break;
        }
    }
}

- (NSURLSessionDataTask *)sendGetRequestByURL:(NSString *)URL
                 withParams:(NSDictionary*)params
           withSuccessBlock:(SuccessBlock)successBlock
               failureBlock:(FailureBlock)failureBlock
{
    NSURLSessionDataTask *sessionTask = [self.manager GET:URL parameters:params progress:nil success:successBlock failure:failureBlock];
    return sessionTask;
}

- (NSURLSessionDataTask *)sendPostRequestByURL:(NSString *)URL
                  withParams:(NSDictionary*)params
            withSuccessBlock:(SuccessBlock)successBlock
                failureBlock:(FailureBlock)failureBlock
{
    return [self.manager POST:URL parameters:params progress:nil success:successBlock failure:failureBlock];
}


@end
