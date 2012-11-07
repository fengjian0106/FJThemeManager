//
//  FJThemeManager.m
//  FJThemeManager
//
//  Created by fengjian on 12-10-29.
//  Copyright (c) 2012年 biti. All rights reserved.
//

#import "FJThemeManager.h"


@implementation FJViewTraceObject

+ (NSMutableSet *)globalSet
{
    static NSMutableSet *globalSet = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        //!! What I need is a Non-Retaining mutable set.
        globalSet = (__bridge_transfer NSMutableSet *)CFSetCreateMutable(nil, 0, nil);
    });
    
    return globalSet;
}

#pragma mark - setter and getter
- (void)setThemeChangeBlock:(FJThemeChangeBlock)themeChangeBlock
{
    _themeChangeBlock = themeChangeBlock;
    
    if (_themeChangeBlock) {
        FJThemeManager *manager = [FJThemeManager sharedInstance];
        FJThemeItem *item = [manager currentThemeItem];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            _themeChangeBlock(item.name, item.color, item.font, item.fontColor);
        });
    }
}

#pragma mark - init and dealloc
- (id)init
{
    self = [super init];
    if (self) {
        [[FJViewTraceObject globalSet] addObject:self];
    }
    return self;
}

- (void)dealloc
{
    [[FJViewTraceObject globalSet] removeObject:self];
}

@end


#pragma mark - @implementation FJThemeManager

@interface FJThemeManager ()

@property (nonatomic, readwrite) NSUInteger currentThemeItemIndex;

@property (nonatomic, strong) NSMutableArray *themeArray;
@property (nonatomic, strong) void (^completionBlock)(void);

@end


@implementation FJThemeManager

+ (FJThemeManager *)sharedInstance
{
    static FJThemeManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FJThemeManager alloc] init];
    });
    return sharedInstance;
}

#pragma mark - setter and getter
- (NSMutableArray *)themeArray
{
    if (!_themeArray) {
        _themeArray = [[NSMutableArray alloc] init];
    }
    
    return _themeArray;
}

- (FJThemeItem *)currentThemeItem
{
    if (self.currentThemeItemIndex == NSNotFound) {
        return nil;
    }
    return [[self.themeArray objectAtIndex:self.currentThemeItemIndex] copy];
}

#pragma mark - init and dealloc
- (id)init
{
    self = [super init];
    if (self) {
        _currentThemeItemIndex = NSNotFound;
    }
    return self;
}

#pragma mark - public method
- (NSUInteger)themedUIViewCount
{
    return [[FJViewTraceObject globalSet] count];
}


- (NSUInteger)themeItemCount
{
    return [self.themeArray count];
}


- (FJThemeItem *)themeItemAtIndex:(NSUInteger)index
{
    if (index >= self.themeItemCount) {
        return nil;
    }
    
    return [[self.themeArray objectAtIndex:index] copy];
}


- (void)addThemeItem:(FJThemeItem *)themeItem
{
    FJThemeItem *newItem = [themeItem copy];
    [self.themeArray addObject:newItem];
}


- (void)removeThemeItemAtIndex:(NSUInteger)index
{
    if (index >= self.themeItemCount) {
        return;
    }
    
    [self.themeArray removeObjectAtIndex:index];
}


- (void)setCurrentThemeItemIndex:(NSUInteger)currentThemeItemIndex withCompletionBlock:(void (^)(void))completionBlock
{
    if (currentThemeItemIndex >= self.themeItemCount) {
        if (completionBlock) {
            completionBlock();
        }
        return;
    }

    self.currentThemeItemIndex = currentThemeItemIndex;
    
    if ([[FJViewTraceObject globalSet] count] == 0) {
        if (completionBlock) {
            completionBlock();
        }
        return;
    }
    
    

    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];

    
    NSBlockOperation *lastOperation = nil;
    NSBlockOperation *currentOperation = nil;
    
    NSEnumerator *enumerator = [[FJViewTraceObject globalSet] objectEnumerator];
    FJViewTraceObject *viewTraceObject;
    
    FJThemeItem *currentItem = [self.themeArray objectAtIndex:self.currentThemeItemIndex];
    while ((viewTraceObject = [enumerator nextObject])) {
        currentOperation = [NSBlockOperation blockOperationWithBlock:^(void) {
            if (viewTraceObject.themeChangeBlock) {
                viewTraceObject.themeChangeBlock(currentItem.name, currentItem.color, currentItem.font, currentItem.fontColor);
            }
        }];
        
        if (lastOperation != nil) {
            [currentOperation addDependency:lastOperation];
        }
        
        lastOperation = currentOperation;
        [[NSOperationQueue mainQueue] addOperation:currentOperation];
    }
    
    [lastOperation setCompletionBlock:^(void) {
        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completionBlock();
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            });
        } else {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
        
        
    }];
}

@end




