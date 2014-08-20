//
//  WLBookDataSource.h
//  Wonderland
//
//  Created by Hoan Tran on 8/20/14.
//  Copyright (c) 2014 Bluepego Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WLPaginator.h"
#import "WLOnePageViewController.h"

@interface WLBookDataSource : NSObject

@property (readonly, nonatomic) WLPaginator *paginator;
- (WLOnePageViewController *)pageViewController:pageViewController loadPage:(NSUInteger)page;

@end
