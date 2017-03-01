//
//  PJTItem.h
//  PunicappJsonTest
//
//  Created by Александр Бонко on 2/28/17.
//  Copyright © 2017 PunicApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PJTItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, strong) NSNumber *uid;

- (id)initModelWithDictionary:(NSDictionary *)dictionary;
- (void)updateModelWithDictionary:(NSDictionary *)dictionary;

@end
