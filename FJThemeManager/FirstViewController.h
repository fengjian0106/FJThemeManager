//
//  FirstViewController.h
//  FJThemeManager
//
//  Created by fengjian on 12-11-1.
//  Copyright (c) 2012年 biti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *setThemeButton;
@property (weak, nonatomic) IBOutlet UIButton *showThemedUIViewCountButton;

- (IBAction)showThemedUIViewCount:(id)sender;

@end
