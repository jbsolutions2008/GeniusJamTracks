//
//  NSObject+AMXFontScale.m
//  AMXFontAutoScale
//
//  Created by Alexandru Maimescu on 3/15/17.
//  Copyright © 2017 Alex Maimescu. All rights reserved.
//

#import "NSObject+AMXFontScale.h"
#import <objc/runtime.h>

@implementation NSObject (AMXFontScale)

+ (void)amx_swizzleInstanceSelector:(SEL)fromSelector withSelector:(SEL)toSelector
{
    Class class = [self class];
    
    Method origMethod = class_getInstanceMethod(self, fromSelector);
    Method overrideMethod = class_getInstanceMethod(self, toSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        fromSelector,
                                        method_getImplementation(overrideMethod),
                                        method_getTypeEncoding(overrideMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            toSelector,
                            method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}

+ (void)amx_swizzleClassSelector:(SEL)fromSelector withSelector:(SEL)toSelector
{
    Method origMethod = class_getClassMethod(self, fromSelector);
    Method overrideMethod = class_getClassMethod(self, toSelector);
    method_exchangeImplementations(origMethod, overrideMethod);
}

- (void)amx_storeObject:(id)object forKey:(const void *)key
{
    objc_setAssociatedObject(self, key, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)amx_getObjectForKey:(const void *)key
{
    return objc_getAssociatedObject(self, key);
}

@end
