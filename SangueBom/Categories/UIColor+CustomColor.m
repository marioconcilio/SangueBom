//
//  UIColor+CustomColor.m
//  SangueBom
//
//  Created by Mario Concilio on 10/22/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "UIColor+CustomColor.h"

@implementation UIColor (CustomColor)

+ (UIColor *)randomColor {
    return [UIColor colorWithHue:arc4random() % 256 / 256.0 saturation:0.7 brightness:0.8 alpha:1.0];
}

+ (UIColor *)customDarkBackground {
    return UIColorFromHEX(0x333333);
}

+ (UIColor *)customRed {
    return UIColorFromHEX(0x800000);
}

+ (UIColor *)customYellow {
    return UIColorFromHEX(0xffff66);
}

+ (UIColor *)customOrange {
    return UIColorFromHEX(0xff8000);
}

@end
