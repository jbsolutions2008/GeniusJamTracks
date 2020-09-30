//
//  Constant.h
//  GeniusJamTracks
//
//  15/05/20.
//  Copyright © 2020 JB Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Constant : NSObject
+(void)setBorderWithColor:(UIColor*)color width:(CGFloat)width toView:(UIView*)view withRadius:(int)radius;
+(UIColor*)createColorWithCode:(int)r green:(int)g blue:(int)b;
+(void)addInnerShadow:(UIView*)view1 blackShadow:(UIView*)view2;
+(void)addGradient:(UIView*)view1;
@end

NS_ASSUME_NONNULL_END
