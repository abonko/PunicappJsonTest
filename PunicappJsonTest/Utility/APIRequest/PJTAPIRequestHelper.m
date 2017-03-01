//
//  PJTAPIRequestHelper.m
//  PunicappJsonTest
//
//  Created by Александр Бонко on 2/28/17.
//  Copyright © 2017 PunicApp. All rights reserved.
//

#import "PJTAPIRequestHelper.h"
//Libraries.
#import "AFNetworking.h"

#import "CheckNetHelper.h"


@implementation PJTAPIRequestHelper



- (id)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

- (NSString *)getFullURLString
{
    return [NSString stringWithFormat:@"%@%@", BASE_URL, self.preffisURL];
}

#pragma mark - GETRequest

- (void)sendGETRequestWithRequestCallback:(RequestCallback)callback;
{
    if (![[CheckNetHelper sharedInstance] isConnected]) {
        if (callback) {
            callback(NO, nil, YES);
        }
        return;
    }
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSString* urlString = [self getFullURLString];
        
    [manager GET:urlString parameters:self.parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success!");
        if (callback) {
            callback(YES, responseObject, NO);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error: %@", error);
        NSLog(@"error.userInfo: %@", error.userInfo);
        if (callback) {
            callback(NO, error, NO);
        }
    }];
}


@end
