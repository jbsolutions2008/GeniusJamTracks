//
//  Constant.m
//  GeniusJamTracks
//
//   15/05/20.
//  Copyright © 2020 JB Solutions. All rights reserved.
//


#import "Constant.h"

@implementation Constant

+ (void)setBorderWithColor:(UIColor *)color width:(CGFloat)width toView:(UIView *)view withRadius:(int)radius {
    
    if (radius != 0) {
        view.layer.masksToBounds = true;
        view.layer.cornerRadius = radius;
    }
    
    view.layer.borderColor = color.CGColor;
    view.layer.borderWidth = width;
}

+ (UIColor *)createColorWithCode:(int)r green:(int)g blue:(int)b {
    return [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:1.0];
}

+ (void)addInnerShadow:(UIView *)view1 blackShadow:(UIView *)view2 {
    
    view1.clipsToBounds = NO;
    view1.layer.shadowColor = [UIColor whiteColor].CGColor;
    view1.layer.shadowOpacity = 1.0;
    view1.layer.shadowOffset = CGSizeMake(0, 1);
    view1.layer.shadowRadius = 1.5;
    
    view2.clipsToBounds = NO;
    view2.layer.shadowColor = [UIColor blackColor].CGColor;
    view2.layer.shadowOpacity = 1.0;
    view2.layer.shadowOffset = CGSizeMake(0, -1);
    view2.layer.shadowRadius = 2.5;
}

+ (void)addGradient:(UIView *)view1 {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view1.bounds;
    gradient.colors = @[(id)[self createColorWithCode:105 green:105 blue:105].CGColor, (id)[self createColorWithCode:74 green:74 blue:74].CGColor];
    gradient.startPoint = CGPointMake(0.0, 0.0);
    gradient.endPoint = CGPointMake(0.0, 1.0);
    [view1.layer insertSublayer:gradient atIndex:0];
}




@end
