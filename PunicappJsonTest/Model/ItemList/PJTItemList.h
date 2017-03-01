//
//  PJTItemList.h
//  PunicappJsonTest
//
//  Created by Александр Бонко on 2/28/17.
//  Copyright © 2017 PunicApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PJTItem.h"

@interface PJTItemList : NSObject

@property (nonatomic, strong) NSArray<PJTItem*> *items;

- (void)loadItemList:(RequestModelCallback)callback;

@end
