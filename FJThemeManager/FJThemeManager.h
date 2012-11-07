//
//  FJThemeManager.h
//  FJThemeManager
//
//  Created by fengjian on 12-10-29.
//  Copyright (c) 2012年 biti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+FJThemeManager.h"
#import "FJThemeItem.h"


@interface FJThemeManager : NSObject

@property (nonatomic, readonly) NSUInteger currentThemeItemIndex;
@property (nonatomic, readonly) FJThemeItem *currentThemeItem;

+ (id)sharedInstance;


- (NSUInteger)themedUIViewCount;

- (NSUInteger)themeItemCount;
- (FJThemeItem *)themeItemAtIndex:(NSUInteger)index;
- (void)addThemeItem:(FJThemeItem *)themeItem;
- (void)removeThemeItemAtIndex:(NSUInteger)index;

- (void)setCurrentThemeItemIndex:(NSUInteger)currentThemeItemIndex withCompletionBlock:(void (^)(void))completionBlock;

@end


/**
 * Interior Helper Object. Do not use it outside.
 **/
@interface FJViewTraceObject : NSObject

@property (nonatomic, strong) FJThemeChangeBlock themeChangeBlock;

@end