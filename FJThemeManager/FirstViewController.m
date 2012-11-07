//
//  FirstViewController.m
//  FJThemeManager
//
//  Created by fengjian on 12-11-1.
//  Copyright (c) 2012年 biti. All rights reserved.
//

#import "FirstViewController.h"
#import "FJThemeManager.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak FirstViewController *weakSelf = self;
    [self.view addThemeChangeBlock:^(NSString *name, UIColor *color, UIFont *font, UIColor *fontColor) {
        weakSelf.view.backgroundColor = color;
        
        NSString *themePath = [[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"theme"]
                               stringByAppendingPathComponent:name];
        
        UIImage *buttonImage = [[UIImage imageWithContentsOfFile:[themePath stringByAppendingPathComponent:@"button.png"]]
                                resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
        UIImage *buttonImageHighlight = [[UIImage imageWithContentsOfFile:[themePath stringByAppendingPathComponent:@"buttonHighlight.png"]]
                                         resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];


        [weakSelf.setThemeButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [weakSelf.setThemeButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
        
        [weakSelf.showThemedUIViewCountButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [weakSelf.showThemedUIViewCountButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
     }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showThemedUIViewCount:(id)sender
{
    NSLog(@"[[FJThemeManager sharedInstance] themeItemCount]=%d", [[FJThemeManager sharedInstance] themedUIViewCount]);
}
@end
