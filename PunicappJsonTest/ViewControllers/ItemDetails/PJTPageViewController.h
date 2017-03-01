//
//  PJTPageViewController.h
//  PunicappJsonTest
//
//  Created by Александр Бонко on 3/1/17.
//  Copyright © 2017 PunicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PJTItem.h"

@interface PJTPageViewController : UIViewController<UIPageViewControllerDataSource>
@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (strong, nonatomic) NSArray<PJTItem*>* items;
@property NSInteger startPageIndex;

@end
