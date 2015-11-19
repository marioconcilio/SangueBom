//
//  Helper.h
//  SangueBom
//
//  Created by Mario Concilio on 10/22/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class VOUser;
@interface Helper : NSObject

+ (VOUser *)loadUser;

+ (void)saveCustomObject:(id)obj forKey:(NSString *)key;

+ (NSString *)initialsFromName:(NSString *)name;

+ (void)avatarFromName:(NSString *)name
                  font:(UIFont *)font
              diameter:(CGFloat)diameter
              callback:(void (^)(UIImage *image))callback;

+ (NSMutableArray *)createAnswersArrayWithCapacity:(NSInteger)capacity;

+ (BOOL)compareAnswers:(NSArray *)answers with:(NSArray *)ans;

+ (NSString *)formatDate:(NSDate *)date;

+ (NSDate *)parseDateFromString:(NSString *)string;

@end
