//
//  Macros.h
//  SangueBom
//
//  Created by Mario Concilio on 10/22/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#define NSUserDefaults      [NSUserDefaults standardUserDefaults]
#define UIKeyWindow         [[UIApplication sharedApplication] keyWindow]
#define UIKeyWindowHeight   CGRectGetHeight([[UIApplication sharedApplication] keyWindow].bounds)
#define UIKeyWindowWidth    CGRectGetWidth([[UIApplication sharedApplication] keyWindow].bounds)
#define UIAppDelegate       ((AppDelegate *)[UIApplication sharedApplication].delegate)

/**
 * Colors from RGB
 */
#define UIColorFromRGB(r, g, b)        [UIColor colorWithRed:((float)r/255.0) green:((float)g/255.0) blue:((float)b/255.0) alpha:(1.0)]
#define UIColorFromRGBA(r, g, b, a)    [UIColor colorWithRed:((float)r/255.0) green:((float)g/255.0) blue:((float)b/255.0) alpha:(a)]

/**
 * Colors from HEX
 */
#define UIColorFromHEX(hex)         [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]

#define UIColorFromHEXA(hex, a)     [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:a]

#endif /* Macros_h */
