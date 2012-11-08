//
//  FJThemeItem.h
//  FJThemeManager
//
//  Created by fengjian on 12-10-29.
//  Copyright (c) 2012年 biti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJThemeItem : NSObject <NSCopying>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) UIColor *color;
@property (nonatomic, copy) UIFont *font;
@property (nonatomic, copy) UIColor *fontColor;
@end
