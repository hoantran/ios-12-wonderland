//
//  WLCharacterDetailViewController.m
//  Wonderland
//
//  Created by Hoan Tran on 8/19/14.
//  Copyright (c) 2014 Bluepego Consulting. All rights reserved.
//

#import "WLCharacterDetailViewController.h"
#import "WLCharacterTableViewController.h"

@interface WLCharacterDetailViewController ()

@end

@implementation WLCharacterDetailViewController

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

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.nameLabel.text = _characterInfo[kNameKey];
    self.imageView.image = [UIImage imageNamed:_characterInfo[kImageKey]];
    self.descriptionView.text = _characterInfo[kDescriptionKey];
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
