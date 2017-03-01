//
//  PJTItemDetailsViewController.h
//  PunicappJsonTest
//
//  Created by Александр Бонко on 3/1/17.
//  Copyright © 2017 PunicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PJTItem.h" 
@interface PJTItemDetailsViewController : UIViewController

@property (nonatomic, strong) PJTItem *item;
@property NSInteger pageIndex;

@end
