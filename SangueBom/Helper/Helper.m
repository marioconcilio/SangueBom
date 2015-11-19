//
//  Helper.m
//  SangueBom
//
//  Created by Mario Concilio on 10/22/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "Helper.h"
#import "Constants.h"
#import "Macros.h"
#import "UIColor+CustomColor.h"
#import "VOUser.h"
#import <JSQMessagesViewController/JSQMessagesAvatarImageFactory.h>
#import <MagicalRecord/MagicalRecord.h>

@implementation Helper

+ (VOUser *)loadUser {
    NSData *myEncodedObject = [NSUserDefaults objectForKey:kProfileInfo];
    VOUser* obj = (VOUser *)[NSKeyedUnarchiver unarchiveObjectWithData:myEncodedObject];
    return obj;
}

+ (void)saveCustomObject:(id)obj forKey:(NSString *)key {
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:obj];
    [NSUserDefaults setObject:myEncodedObject forKey:key];
}
+ (NSString *)initialsFromName:(NSString *)name {
    NSMutableString * firstCharacters = [NSMutableString string];
    NSArray * words = [name componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    for (NSString *word in words) {
        if (word.length > 0) {
            NSString * firstLetter = [word substringWithRange:[word rangeOfComposedCharacterSequenceAtIndex:0]];
            [firstCharacters appendString:[firstLetter uppercaseString]];
        }
    }
    
    return firstCharacters;
}

+ (void)avatarFromName:(NSString *)name font:(UIFont *)font diameter:(CGFloat)diameter callback:(void (^)(UIImage *image))callback {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        JSQMessagesAvatarImage *avatar = [JSQMessagesAvatarImageFactory avatarImageWithUserInitials:[self initialsFromName:name]
                                                                                    backgroundColor:[UIColor randomColor]
                                                                                          textColor:[UIColor whiteColor]
                                                                                               font:font
                                                                                           diameter:diameter];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(avatar.avatarImage);
        });
    });
}

+ (NSMutableArray *)createAnswersArrayWithCapacity:(NSInteger)capacity {
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:capacity];
    for (NSInteger i=0; i<capacity; i++) {
        @autoreleasepool {
            [array addObject:@(NO)];
        }
    }
    
    return array;
}

+ (BOOL)compareAnswers:(NSArray *)answers with:(NSArray *)ans {
    if (answers.count != ans.count) {
        return NO;
    }
    
    for (NSInteger i=0; i<ans.count; i++) {
        if ([ans[i] boolValue] != [answers[i] boolValue]) {
            return NO;
        }
    }
    
    return YES;
}

+ (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd-MM-yyyy";
    
    return [formatter stringFromDate:date];
}

+ (NSDate *)parseDateFromString:(NSString *)string {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd-MM-yyyy";
    
    return [formatter dateFromString:string];
}

@end
