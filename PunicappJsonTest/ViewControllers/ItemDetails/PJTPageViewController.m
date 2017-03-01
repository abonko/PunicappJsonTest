//
//  PJTPageViewController.m
//  PunicappJsonTest
//
//  Created by Александр Бонко on 3/1/17.
//  Copyright © 2017 PunicApp. All rights reserved.
//

#import "PJTPageViewController.h"
#import "PJTItemDetailsViewController.h"

@interface PJTPageViewController ()

@end

@implementation PJTPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageVC"];
    self.pageViewController.dataSource = self;
    
    PJTItemDetailsViewController *startingViewController = [self viewControllerAtIndex:_startPageIndex];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startWalkthrough:(id)sender {
    PJTItemDetailsViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

- (PJTItemDetailsViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.items count] == 0) || (index >= [self.items count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PJTItemDetailsViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PJTItemDetailsViewController"];
    pageContentViewController.item = self.items[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PJTItemDetailsViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PJTItemDetailsViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }

    index++;
    if (index == [self.items count]) {
        return nil;
    
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.items count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
