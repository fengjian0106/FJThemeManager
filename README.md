FJThemeManager
==============

Every programmer can implement his/her own theme managerment in IOS. Perhaps using delegate, NSNotificationCenter or subclass UIView. But it is too complex for me. So I wrote my own one, and it's super easy to use, just add one line code, as follows
```  objc
[self.view addThemeChangeBlock:^(NSString *name, UIColor *color, UIFont *font, UIColor *fontColor) {...};
```

The key technology is Objective-C runtime func and a Non-Retaining mutable set. 

Screenshot
---
![red](https://raw.github.com/fengjian0106/FJThemeManager/master/screenshot/red.png)
  ![green](https://raw.github.com/fengjian0106/FJThemeManager/master/screenshot/green.png)
![blue](https://raw.github.com/fengjian0106/FJThemeManager/master/screenshot/blue.png)
  ![set_and_test](https://raw.github.com/fengjian0106/FJThemeManager/master/screenshot/set_and_test.png)




Example 1: add theme support to UIViewController.view
---

```  objc
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
```


Example 2: add theme support to UINavigationController
---

```  objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    __weak AppDelegate *weakSelf = self;
    [self.window.rootViewController.view addThemeChangeBlock:^(NSString *name, UIColor *color, UIFont *font, UIColor *fontColor) {

        NSString *themePath = [[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"theme"]
                               stringByAppendingPathComponent:name];
        

        UIImage *gradientImage44 = [[UIImage imageWithContentsOfFile:[themePath stringByAppendingPathComponent:@"navTexture44.png"]]
                                    resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        UIImage *gradientImage32 = [[UIImage imageWithContentsOfFile:[themePath stringByAppendingPathComponent:@"navTexture32.png"]]
                                    resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        
        [((UINavigationController *)(weakSelf.window.rootViewController)).navigationBar setBackgroundImage:gradientImage44
                                                                                             forBarMetrics:UIBarMetricsDefault];
        [((UINavigationController *)(weakSelf.window.rootViewController)).navigationBar setBackgroundImage:gradientImage32
                                                                                             forBarMetrics:UIBarMetricsLandscapePhone];

    }];
    
    
    return YES;
}
```


Example 3: add theme support to UITableViewCell
---

```  objc
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
```


Example 4: add theme to themeManager and set init theme index
---

```  objc
FJThemeManager *themeManager = [FJThemeManager sharedInstance];
    if ([themeManager themeItemCount] == 0) {
        FJThemeItem *item = [[FJThemeItem alloc] init];
        item.name = @"redTheme";
        item.color = [UIColor redColor];
        [themeManager addThemeItem:item];
        
        item = [[FJThemeItem alloc] init];
        item.name = @"greenTheme";
        item.color = [UIColor greenColor];
        [themeManager addThemeItem:item];
        
        item = [[FJThemeItem alloc] init];
        item.name = @"blueTheme";
        item.color = [UIColor blueColor];
        [themeManager addThemeItem:item];
        
        [themeManager setCurrentThemeItemIndex:0 withCompletionBlock:nil];
    } else {
        //
    }
```


Example 5: change theme
---

```  objc
- (IBAction)segmentValueChanged:(id)sender
{
    self.hudView.hidden = NO;
    [self.indicator startAnimating];
    
    
    [[FJThemeManager sharedInstance] setCurrentThemeItemIndex:self.segment.selectedSegmentIndex withCompletionBlock:^(void) {
        self.hudView.hidden = YES;
        [self.indicator stopAnimating];
    }];
}
```


How to use
---

6 files are required: ` UIView+FJThemeManager.h/.m `, ` FJThemeManager.h/.m ` and `FJThemeItem.h/.m`.

So drag the `FJThemeManager` folder into your project.

And in your code, just `#import "FJThemeManager.h"`


License
---
FJThemeManager uses the 2-clause BSD license. So you should be free to use it pretty much however 
you want.

Copyright (c) 2012 FengJian. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.