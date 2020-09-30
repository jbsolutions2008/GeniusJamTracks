//
//  AMXFontAutoScalable.h
//  AMXFontAutoScale
//
//  Created by Alexandru Maimescu on 3/15/17.
//  Copyright © 2017 Alex Maimescu. All rights reserved.
//

#ifndef AMXFontAutoScalable_h
#define AMXFontAutoScalable_h

#import <CoreGraphics/CoreGraphics.h>

typedef void (^AMXFontUpdateHandler)(CGFloat originalSize, CGFloat preferredSize, CGFloat multiplier);

typedef NS_ENUM(NSInteger, AMXScreenSize) {
    AMXScreenSizeCurrent,
    AMXScreenSize3p5Inch,
    AMXScreenSize4Inch,
    AMXScreenSize4p7Inch,
    AMXScreenSize5p5Inch,
    AMXScreenSize5p8Inch,
    AMXScreenSize7p9Inch,
    AMXScreenSize9p7Inch,
    AMXScreenSizeLandscape,
    AMXScreenSizeIpadLandscape,
    AMXScreenSize12p9Inch
};

@protocol AMXFontAutoScalable <NSObject>

@property (nonatomic, class, setter=set_amx_autoScaleEnabled:) BOOL amx_autoScaleEnabled;
@property (nonatomic, assign, setter=set_amx_autoScaleEnabled:) BOOL amx_autoScaleEnabled;

@property (nonatomic, assign, setter=set_amx_referenceScreenSize:) AMXScreenSize amx_referenceScreenSize;
@property (nonatomic, class, setter=set_amx_referenceScreenSize:) AMXScreenSize amx_referenceScreenSize;

@property (nonatomic, assign, setter=set_amx_originalFontPointSize:) CGFloat amx_originalFontPointSize;
@property (nonatomic, assign, setter=set_amx_fontSizeUpdateHandler:) AMXFontUpdateHandler amx_fontSizeUpdateHandler;

@end

#endif /* AMXFontAutoScalable_h */
