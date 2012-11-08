//
//  UIView+FJThemeManager.m
//  FJThemeManager
//
//  Created by fengjian on 12-10-29.
//  Copyright (c) 2012年 biti. All rights reserved.
//

#import "UIView+FJThemeManager.h"
#import "FJThemeManager.h"
#import <objc/runtime.h>


static char UIViewFJThemeManagerViewTraceOjbect;

@interface UIView (FJThemeManagerPri)

@property (nonatomic, strong) FJViewTraceObject *viewTraceObject;

@end

@implementation UIView (FJThemeManagerPri)

@dynamic viewTraceObject;

#pragma mark - setter and getter

- (void)setViewTraceObject:(FJViewTraceObject *)viewTraceObject
{
    objc_setAssociatedObject(self, &UIViewFJThemeManagerViewTraceOjbect, viewTraceObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (FJViewTraceObject *)viewTraceObject
{
    return objc_getAssociatedObject(self, &UIViewFJThemeManagerViewTraceOjbect);
}


@end




@implementation UIView (FJThemeManager)

#pragma mark - public method
- (void)addThemeChangeBlock:(FJThemeChangeBlock)newThemeChangeBlock;
{
    if (!self.viewTraceObject) {
        FJViewTraceObject *viewTraceObject = [[FJViewTraceObject alloc] init];
        self.viewTraceObject = viewTraceObject;
    }

    self.viewTraceObject.themeChangeBlock = newThemeChangeBlock;
}

@end
