//
//  UIFont+AMXFontScale.h
//  AMXFontAutoScale
//
//  Created by Alexandru Maimescu on 3/15/17.
//  Copyright © 2017 Alex Maimescu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMXFontAutoScalable.h"

@interface UIFont (AMXFontScale)

- (instancetype)amx_scaledFontForReferenceScreenSize:(AMXScreenSize)screenSize;

- (CGFloat)amx_fontPointSizeMultiplierForReferenceScreenSize:(AMXScreenSize)screenSize;

@end
