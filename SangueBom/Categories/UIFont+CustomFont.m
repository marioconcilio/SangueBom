//
//  UIFont+CustomFont.m
//  SangueBom
//
//  Created by Mario Concilio on 10/23/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "UIFont+CustomFont.h"

@implementation UIFont (CustomFont)

+ (UIFont *)customBoldFontWithSize:(CGFloat)size {
    return [self fontWithName:@"HelveticaNeue-Bold" size:size];
}

+ (UIFont *)customMediumFontWithSize:(CGFloat)size {
    return [self fontWithName:@"HelveticaNeue-Medium" size:size];
}

+ (UIFont *)customRegularFontWithSize:(CGFloat)size {
    return [self fontWithName:@"HelveticaNeue" size:size];
}

+ (UIFont *)customLightFontWithSize:(CGFloat)size {
    return [self fontWithName:@"HelveticaNeue-Light" size:size];
}

+ (UIFont *)customThinFontWithSize:(CGFloat)size {
    return [self fontWithName:@"HelveticaNeue-Thin" size:size];
}

+ (UIFont *)customUltraLightFontWithSize:(CGFloat)size {
    return [self fontWithName:@"HelveticaNeue-UltraLight" size:size];
}

@end
