//
//  DetailViewController.h
//  FJThemeManager
//
//  Created by fengjian on 12-10-29.
//  Copyright (c) 2012年 biti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
