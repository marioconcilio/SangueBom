//
//  Helper.h
//  SangueBom
//
//  Created by Mario Concilio on 10/22/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Person;
@interface Helper : NSObject

+ (Person *)loadUser;
+ (void)saveCustomObject:(id)obj forKey:(NSString *)key;
+ (NSString *)initialsFromName:(NSString *)name;
+ (void)avatarFromName:(NSString *)name font:(UIFont *)font diameter:(CGFloat)diameter callback:(void (^)(UIImage *image))callback;

@end
