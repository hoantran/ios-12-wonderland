//
//  WLBookViewController.m
//  Wonderland
//
//  Created by Hoan Tran on 8/20/14.
//  Copyright (c) 2014 Bluepego Consulting. All rights reserved.
//

#import "WLBookViewController.h"
#import "WLBookDataSource.h"

@interface WLBookViewController ()
{
    WLBookDataSource *bookSource;
}
@end

@implementation WLBookViewController

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
    self.dataSource = bookSource = [WLBookDataSource new];
    
    NSURL *bookURL = [[NSBundle mainBundle] URLForResource:@"Alice" withExtension:@"txt"];
    NSString *text = [NSString stringWithContentsOfURL:bookURL encoding:NSUTF8StringEncoding error:NULL];
    bookSource.paginator.bookText = text;
    
    [self setViewControllers:@[[bookSource pageViewController:self loadPage:1]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
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
