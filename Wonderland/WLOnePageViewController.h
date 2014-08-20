//
//  WLOnePageViewController.h
//  Wonderland
//
//  Created by Hoan Tran on 8/20/14.
//  Copyright (c) 2014 Bluepego Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLOnePageView.h"
#import "WLPaginator.h"

@interface WLOnePageViewController : UIViewController

@property (nonatomic) NSUInteger pageNumber;
@property (strong,nonatomic) WLPaginator *paginator;
@property (weak, nonatomic) IBOutlet WLOnePageView *textView;
@property (weak, nonatomic) IBOutlet UILabel *pageLabel;

@end
