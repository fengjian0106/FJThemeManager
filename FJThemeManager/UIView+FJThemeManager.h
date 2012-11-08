//
//  UIView+FJThemeManager.h
//  FJThemeManager
//
//  Created by fengjian on 12-10-29.
//  Copyright (c) 2012年 biti. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FJThemeChangeBlock)(NSString *name, UIColor *color, UIFont *font, UIColor *fontColor);

@interface UIView (FJThemeManager)

/**
 * the newThemeChangeBlock will be call one OR more times
 * 1. if there is a "current theme", newThemeChangeBlock will be called with the "current theme" at once.
 * 2. after the calling of addThemeChangeBlock, this UIView will be registerd with "theme change", so when current theme changed, newThemeChangeBlock will be call again
 */
- (void)addThemeChangeBlock:(FJThemeChangeBlock)newThemeChangeBlock;

@end
