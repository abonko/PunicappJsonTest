//
//  PJTAPIRequestHelper.h
//  PunicappJsonTest
//
//  Created by Александр Бонко on 2/28/17.
//  Copyright © 2017 PunicApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^RequestCallback)(BOOL status, id response, BOOL isNeedConnection);


@interface PJTAPIRequestHelper : NSObject

@property (nonatomic, strong) NSString *preffisURL;
@property (nonatomic, strong) NSMutableDictionary *parameters;

- (void)sendGETRequestWithRequestCallback:(RequestCallback)callback;

@end

