//
//  Helper.m
//  SangueBom
//
//  Created by Mario Concilio on 10/22/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "Helper.h"
#import "Person.h"
#import "Macros.h"
#import "UIColor+CustomColor.h"
#import <JSQMessagesViewController/JSQMessagesAvatarImageFactory.h>
#import <MagicalRecord/MagicalRecord.h>

@implementation Helper

+ (Person *)loadUser {
    NSString *email = [NSUserDefaults objectForKey:kUserToken];
    return [Person MR_findFirstByAttribute:@"email" withValue:email];
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

@end
