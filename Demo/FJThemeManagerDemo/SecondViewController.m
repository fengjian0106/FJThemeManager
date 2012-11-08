//
//  SecondViewController.m
//  FJThemeManager
//
//  Created by fengjian on 12-11-1.
//  Copyright (c) 2012年 biti. All rights reserved.
//

#import "SecondViewController.h"
#import "FJThemeManager.h"

@interface SecondViewController ()

@property (nonatomic, strong) NSMutableArray *objects;
@end

@implementation SecondViewController

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
    
    self.segment.selectedSegmentIndex = [[FJThemeManager sharedInstance] currentThemeItemIndex];
	
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    testButton.frame = CGRectMake(0.0, 0.0, 60.0, 25.0);
    [testButton setTitle:@"Show Themed UIView count" forState:UIControlStateNormal];
    [testButton addTarget:self action:@selector(showThemedUIViewCount:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = testButton;
    
    __weak UIButton *weakButton = testButton;
    [testButton addThemeChangeBlock:^(NSString *name, UIColor *color, UIFont *font, UIColor *fontColor) {
        NSString *themePath = [[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"theme"]
                               stringByAppendingPathComponent:name];
        
        UIImage *buttonImage = [[UIImage imageWithContentsOfFile:[themePath stringByAppendingPathComponent:@"button.png"]]
                                resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
        UIImage *buttonImageHighlight = [[UIImage imageWithContentsOfFile:[themePath stringByAppendingPathComponent:@"buttonHighlight.png"]]
                                         resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
        
        
        [weakButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [weakButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    __weak UITableViewCell *weakCell = cell;
    [cell addThemeChangeBlock:^(NSString *name, UIColor *color, UIFont *font, UIColor *fontColor) {
        weakCell.backgroundColor = color;
    }];
    
    
    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

- (IBAction)segmentValueChanged:(id)sender
{
    self.hudView.hidden = NO;
    [self.indicator startAnimating];
    
    
    [[FJThemeManager sharedInstance] setCurrentThemeItemIndex:self.segment.selectedSegmentIndex withCompletionBlock:^(void) {
        self.hudView.hidden = YES;
        [self.indicator stopAnimating];
    }];
}

- (void)showThemedUIViewCount:(id)sender
{
    NSLog(@"[[FJThemeManager sharedInstance] themeItemCount]=%d", [[FJThemeManager sharedInstance] themedUIViewCount]);
}
@end
