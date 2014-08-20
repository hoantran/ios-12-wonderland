//
//  WLCharacterDetailViewController.h
//  Wonderland
//
//  Created by Hoan Tran on 8/19/14.
//  Copyright (c) 2014 Bluepego Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLCharacterDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionView;

@property (strong, nonatomic) NSDictionary *characterInfo;

@end
