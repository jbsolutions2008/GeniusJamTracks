//
//  UILabel+AMXFontScale.h
//  AMXFontAutoScale
//
//  Created by Alexandru Maimescu on 3/15/17.
//  Copyright © 2017 Alex Maimescu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMXFontAutoScalable.h"

@interface UILabel (AMXFontScale) <AMXFontAutoScalable>

/**
 IBInspectable alias for amx_autoScaleEnabled property.
 */
@property (nonatomic, assign) IBInspectable BOOL autoScale;

// FIXME: Move the methods below back to AMXFontAutoScalable protocol when the Swift bug SR-5959
// https://bugs.swift.org/browse/SR-5959 will be fixed and released as part of Xcode (probably Swift 4.1)

- (void)amx_autoScaleFontForReferenceScreenSize:(AMXScreenSize)screenSize;
+ (void)amx_autoScaleFontForReferenceScreenSize:(AMXScreenSize)screenSize;

@end
