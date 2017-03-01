//
//  PJTItemList.m
//  PunicappJsonTest
//
//  Created by Александр Бонко on 2/28/17.
//  Copyright © 2017 PunicApp. All rights reserved.
//

#import "PJTItemList.h"
#import "PJTAPIRequestHelper.h"

@implementation PJTItemList

- (void)updateModelWithArray:(NSArray *)responseArray;
{
    @try {
        NSMutableArray<PJTItem*> *tempArray = [[NSMutableArray alloc] init];
        for (NSDictionary *itemDictionary in responseArray) {
            PJTItem* item = [[PJTItem alloc] initModelWithDictionary:itemDictionary];
            if(item){
                [tempArray addObject:item];
            }
            if (tempArray.count > 0) {
                self.items = [[NSArray alloc] initWithArray:tempArray];
            }

        }

    }
    @catch (NSException *exception) {
        NSLog(@"Error parsing item %@", exception.description);
    }
}

- (void)loadItemList:(RequestModelCallback)callback;
{
    PJTAPIRequestHelper *request = [[PJTAPIRequestHelper alloc] init];
    request.preffisURL = @"/androids";
    @weakify(self);
    [request sendGETRequestWithRequestCallback:^(BOOL status, id response, BOOL isNeedConnection) {
        @strongify(self);
        if (status) {
            [self updateModelWithArray:response];
        }
        if (callback) {
            callback(status, isNeedConnection);
        }
    }];

}

@end
