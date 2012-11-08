//
//  FJThemeItem.m
//  FJThemeManager
//
//  Created by fengjian on 12-10-29.
//  Copyright (c) 2012年 biti. All rights reserved.
//

#import "FJThemeItem.h"

@implementation FJThemeItem

- (NSString *)name
{
    if (!_name || [_name isEqual:[NSNull null]]) {
        _name = [[NSString alloc] initWithFormat:@"%@",@"NoNameTheme"];
    }
    
    return _name;
}

- (UIColor *)color
{
    if (!_color) {
        _color = [UIColor clearColor];
    }
    
    return _color;
}

- (UIFont *)font
{
    if (!_font) {
        _font = [UIFont systemFontOfSize:10.0];
    }
    return _font;
}

- (UIColor *)fontColor
{
    if (!_fontColor) {
        _fontColor = [UIColor clearColor];
    }
    
    return _fontColor;
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone
{
    FJThemeItem *copy = [[[self class] allocWithZone: zone] init];
    
    copy.name = [self.name copyWithZone:zone];
    copy.color = [self.color copyWithZone:zone];
    copy.font = [self.font copyWithZone:zone];
    copy.fontColor = [self.fontColor copyWithZone:zone];
    
    return copy;
}

@end
