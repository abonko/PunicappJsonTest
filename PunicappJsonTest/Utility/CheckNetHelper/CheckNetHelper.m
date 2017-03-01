//
//  CheckNetHelper.m
//  PunicappJsonTest
//
//  Created by Александр Бонко on 2/28/17.
//  Copyright © 2017 PunicApp. All rights reserved.
//

#import "CheckNetHelper.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"


@implementation CheckNetHelper
+ (instancetype)sharedInstance{
    static CheckNetHelper *__strong sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CheckNetHelper alloc] init];
    });
    return sharedInstance;
}
- (BOOL)isConnected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}
@end
