//
//  NSObject+AMXFontScale.h
//  AMXFontAutoScale
//
//  Created by Alexandru Maimescu on 3/15/17.
//  Copyright © 2017 Alex Maimescu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AMXFontScale)

+ (void)amx_swizzleInstanceSelector:(SEL)fromSelector
                       withSelector:(SEL)toSelector;

+ (void)amx_swizzleClassSelector:(SEL)fromSelector
                    withSelector:(SEL)toSelector;

- (void)amx_storeObject:(id)object forKey:(const void *)key;
- (id)amx_getObjectForKey:(const void *)key;

@end
