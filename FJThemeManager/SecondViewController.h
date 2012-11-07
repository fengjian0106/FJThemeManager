//
//  SecondViewController.h
//  FJThemeManager
//
//  Created by fengjian on 12-11-1.
//  Copyright (c) 2012年 biti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *hudView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

- (IBAction)segmentValueChanged:(id)sender;

@end
