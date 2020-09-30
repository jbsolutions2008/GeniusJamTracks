//
//  BlockWrapper.h
//  AMXFontAutoScale
//
//  Created by Alexandru Maimescu on 8/1/17.
//  Copyright © 2017 Alex Maimescu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AMXFontAutoScalable.h"

@interface FontUpdateBlockWrapper : NSObject

@property (nonatomic) AMXFontUpdateHandler fontUpdateHandler;

@end
