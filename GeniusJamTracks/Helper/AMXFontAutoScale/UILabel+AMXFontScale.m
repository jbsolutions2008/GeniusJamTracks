//
//  UILabel+AMXFontScale.m
//  AMXFontAutoScale
//
//  Created by Alexandru Maimescu on 3/15/17.
//  Copyright © 2017 Alex Maimescu. All rights reserved.
//

#import "UILabel+AMXFontScale.h"
#import "NSObject+AMXFontScale.h"
#import "UIFont+AMXFontScale.h"

#import "FontUpdateBlockWrapper.h"

static AMXScreenSize s_globalReferenceScreenSize = AMXScreenSizeCurrent;
static BOOL s_globalAutoScaleEnabled = NO;

@implementation UILabel (AMXFontScale)

#pragma mark - Class API (Global)

+ (void)amx_autoScaleFontForReferenceScreenSize:(AMXScreenSize)screenSize
{
    [self set_amx_autoScaleEnabled:YES];
    [self set_amx_referenceScreenSize:screenSize];
}

+ (BOOL)amx_autoScaleEnabled
{
    return s_globalAutoScaleEnabled;
}

+ (void)set_amx_autoScaleEnabled:(BOOL)autoScaleEnabled
{
    s_globalAutoScaleEnabled = autoScaleEnabled;
}

+ (AMXScreenSize)amx_referenceScreenSize
{
    return s_globalReferenceScreenSize;
}

+ (void)set_amx_referenceScreenSize:(AMXScreenSize)referenceScreenSize
{
    s_globalReferenceScreenSize = referenceScreenSize;
}

#pragma mark - IBInspectable accessors

- (BOOL)autoScale
{
    return self.amx_autoScaleEnabled;
}

- (void)setAutoScale:(BOOL)autoScale
{
    self.amx_autoScaleEnabled = autoScale;
}

#pragma mark - Instance API

- (void)amx_autoScaleFontForReferenceScreenSize:(AMXScreenSize)screenSize
{
    self.amx_autoScaleEnabled = YES;
    self.amx_referenceScreenSize = screenSize;
}

- (BOOL)amx_autoScaleEnabled
{
    return [[self amx_getObjectForKey:@selector(amx_autoScaleEnabled)] boolValue];
}

- (void)set_amx_autoScaleEnabled:(BOOL)endabled
{
    [self amx_storeObject:@(endabled) forKey:@selector(amx_autoScaleEnabled)];
}

- (AMXScreenSize)amx_referenceScreenSize
{
    return [[self amx_getObjectForKey:@selector(amx_referenceScreenSize)] integerValue];
}

- (void)set_amx_referenceScreenSize:(AMXScreenSize)referenceScreenSize
{
    [self amx_storeObject:@(referenceScreenSize) forKey:@selector(amx_referenceScreenSize)];
}

- (AMXFontUpdateHandler)amx_fontSizeUpdateHandler
{
    FontUpdateBlockWrapper *wrapper = [self amx_getObjectForKey:@selector(amx_fontSizeUpdateHandler)];
    
    return wrapper.fontUpdateHandler;
}

- (void)set_amx_fontSizeUpdateHandler:(AMXFontUpdateHandler)fontSizeUpdateHandler
{
    FontUpdateBlockWrapper *wrapper = [FontUpdateBlockWrapper new];
    wrapper.fontUpdateHandler = fontSizeUpdateHandler;
    
    [self amx_storeObject:wrapper forKey:@selector(amx_fontSizeUpdateHandler)];
}

- (CGFloat)amx_originalFontPointSize
{
    NSNumber *storedFontPointSize = [self amx_getObjectForKey:@selector(amx_originalFontPointSize)];
    
    return (storedFontPointSize) ? [storedFontPointSize floatValue] : self.font.pointSize;
}

- (void)set_amx_originalFontPointSize:(CGFloat)originalFontPointSize
{
    [self amx_storeObject:@(originalFontPointSize) forKey:@selector(amx_originalFontPointSize)];
}

#pragma mark - Utils

- (BOOL)wasInstanceAutoScaleReferenceDefined
{
    return [self amx_getObjectForKey:@selector(amx_referenceScreenSize)] != nil;
}

- (BOOL)wasInstanceAutoScaleExplicitlyDisabled
{
    return ([self amx_getObjectForKey:@selector(amx_autoScaleEnabled)] != nil) &&
            (self.amx_autoScaleEnabled == NO);
}

#pragma mark - Swizzles


+ (void)load
{
    [self amx_swizzleInstanceSelector:@selector(willMoveToWindow:)
                         withSelector:@selector(swizzle_willMoveToWindow:)];
}

- (void)swizzle_willMoveToWindow:(UIWindow *)newWindow
{
    BOOL scalingIsNeeded = roundf(self.amx_originalFontPointSize) == roundf(self.font.pointSize);
    
    if (newWindow && scalingIsNeeded) {
        AMXScreenSize referenceScreenSize = AMXScreenSizeCurrent;
        
        // Get the reference screen size
        if (self.amx_autoScaleEnabled) {
            referenceScreenSize = [self wasInstanceAutoScaleReferenceDefined]
                ? self.amx_referenceScreenSize
                : self.class.amx_referenceScreenSize;
        } else if (self.class.amx_autoScaleEnabled && [self wasInstanceAutoScaleExplicitlyDisabled] == NO) {
            referenceScreenSize = self.class.amx_referenceScreenSize;
        }
        
        // Apply scaling if needed
        if (referenceScreenSize != AMXScreenSizeCurrent) {
            self.amx_originalFontPointSize = self.font.pointSize;
            CGFloat multiplier = [self.font amx_fontPointSizeMultiplierForReferenceScreenSize:referenceScreenSize];
            self.font = [self.font amx_scaledFontForReferenceScreenSize:referenceScreenSize];
            
            // Call update handler if set
            if (self.amx_fontSizeUpdateHandler) {
                self.amx_fontSizeUpdateHandler(self.amx_originalFontPointSize, self.font.pointSize, multiplier);
            }
        }
    }
    
    [self swizzle_willMoveToWindow:newWindow];
}

@end
