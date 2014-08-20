//
//  WLBookDataSource.m
//  Wonderland
//
//  Created by Hoan Tran on 8/20/14.
//  Copyright (c) 2014 Bluepego Consulting. All rights reserved.
//

#import "WLBookDataSource.h"

@interface WLBookDataSource()
{
    WLPaginator *paginator;
}
@end

@implementation WLBookDataSource

- (WLPaginator*)paginator
{
    if (paginator == nil) {
        paginator = [WLPaginator new];
        paginator.font = [UIFont fontWithName:@"Times New Roman" size:18];
    }
    return paginator;
}

- (WLOnePageViewController*)pageViewController:(UIPageViewController*)pageViewController loadPage:(NSUInteger)page
{
    if (page<1 || ![paginator availablePage:page]) {
        return nil;
    }
    WLOnePageViewController *controller;
    controller = [pageViewController.storyboard instantiateViewControllerWithIdentifier:@"OnePage"];
    controller.paginator = self.paginator;
    controller.pageNumber = page;
    return controller;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
                        viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger currentPageNumber = ((WLOnePageViewController*)viewController).pageNumber;
    return [self pageViewController:pageViewController loadPage:currentPageNumber+1];
}

- (UIViewController*)pageViewController:(UIPageViewController *)pageViewController
                        viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger currentPageNumber = ((WLOnePageViewController*)viewController).pageNumber;
    return [self pageViewController:pageViewController loadPage:currentPageNumber-1];
}
@end
