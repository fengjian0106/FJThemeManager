//
//  AppDelegate.m
//  FJThemeManager
//
//  Created by fengjian on 12-10-29.
//  Copyright (c) 2012年 biti. All rights reserved.
//

#import "AppDelegate.h"
#import "FJThemeManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
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
        
        NSLog(@"[themeManager currentThemeItem]=%@", [themeManager currentThemeItem]);
    } else {
        //
    }

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
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
