//
//  UIFont+CustomFont.h
//  SangueBom
//
//  Created by Mario Concilio on 10/23/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (CustomFont)

+ (UIFont *)customBoldFontWithSize:(CGFloat)size;
+ (UIFont *)customMediumFontWithSize:(CGFloat)size;
+ (UIFont *)customRegularFontWithSize:(CGFloat)size;
+ (UIFont *)customLightFontWithSize:(CGFloat)size;
+ (UIFont *)customThinFontWithSize:(CGFloat)size;
+ (UIFont *)customUltraLightFontWithSize:(CGFloat)size;

@end
