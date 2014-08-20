//
//  WLOnePageViewController.m
//  Wonderland
//
//  Created by Hoan Tran on 8/20/14.
//  Copyright (c) 2014 Bluepego Consulting. All rights reserved.
//

#import "WLOnePageViewController.h"

@interface WLOnePageViewController ()
- (void) loadPageContent;
@end

@implementation WLOnePageViewController

- (void) loadPageContent
{
    _paginator.viewSize = _textView.bounds.size;
    if (![_paginator availablePage:_pageNumber]) {
        _pageNumber = _paginator.lastKnownPage;
    }
    _textView.fontAttrs = _paginator.fontAttrs;
    _textView.text = [_paginator textForPage:_pageNumber];
    [_textView setNeedsDisplay];
    _pageLabel.text = [NSString stringWithFormat:@"Page %u", (unsigned int)_pageNumber];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self loadPageContent];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
