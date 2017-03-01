//
//  PJTItem.m
//  PunicappJsonTest
//
//  Created by Александр Бонко on 2/28/17.
//  Copyright © 2017 PunicApp. All rights reserved.
//

#import "PJTItem.h"

@implementation PJTItem


- (id)initModelWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self) {
        [self updateModelWithDictionary:dictionary];
    }
    return self;
}


- (void)updateModelWithDictionary:(NSDictionary *)dictionary;
{
    @try {
        self.uid = dictionary[@"id"];
        self.title = dictionary[@"title"];
        self.img = dictionary[@"img"];
    }
    @catch (NSException *exception) {
        NSLog(@"Error parsing item %@", exception.description);
    }
}

@end
