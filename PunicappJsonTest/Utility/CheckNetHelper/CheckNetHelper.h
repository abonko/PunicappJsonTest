//
//  CheckNetHelper.h
//  PunicappJsonTest
//
//  Created by Александр Бонко on 2/28/17.
//  Copyright © 2017 PunicApp. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NetHelper [CheckNetHelper sharedInstance]

@interface CheckNetHelper : NSObject
+ (instancetype)sharedInstance;
- (BOOL)isConnected;
@end
