//
//  WLCharacterTableViewController.h
//  Wonderland
//
//  Created by Hoan Tran on 8/19/14.
//  Copyright (c) 2014 Bluepego Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kImageKey       @"image"
#define kNameKey        @"name"
#define kDescriptionKey @"description"

@interface WLCharacterTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *tableData;

@end
