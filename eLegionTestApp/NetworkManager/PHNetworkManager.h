//
//  NetworkManager.h
//  Posh
//
//  Created by Nikita on 18.01.16.
//  Copyright © 2016 Nikita Popov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkConfig.h"

typedef NS_ENUM(NSUInteger, RequestType) {
    RequestTypeGet,
    RequestTypePost
};

typedef void (^SuccessBlock)(NSURLSessionTask *task, id responseObject);
typedef void (^FailureBlock)(NSURLSessionDataTask * task, NSError * error);

typedef void (^ControllerSuccessBlock)(BOOL success);
typedef void (^ControllerFailureBlock)(NSString *error);

@class AFHTTPRequestOperation;

@interface PHNetworkManager : NSObject

+ (instancetype)sharedInstance;

- (NSURLSessionDataTask *)sendRequestWithType:(RequestType)type
                      byURL:(NSString*)url
                 withParams:(NSDictionary*)params
           withSuccessBlock:(SuccessBlock)successBlock
            andFailureBlock:(FailureBlock)failureBlock;

@end
