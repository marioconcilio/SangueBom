//
//  APIService.h
//  SangueBom
//
//  Created by Mario Concilio on 9/16/15.
//  Copyright (c) 2015 Mario Concilio. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^APIDefaultBlock)(NSError *error);

@class UIImage;
@interface APIService : NSObject

+ (instancetype)sharedInstance;

- (void)registerUser:(NSString *)name
               email:(NSString *)email
            password:(NSString *)password
           bloodType:(NSString *)bloodType
            birthday:(NSString *)birthday
               block:(APIDefaultBlock)block;

- (void)login:(NSString *)email
     password:(NSString *)password
        block:(APIDefaultBlock)block;

- (void)updateUserBloodType:(NSString *)bloodType
                      email:(NSString *)email
                   password:(NSString *)password
                      block:(APIDefaultBlock)block;

- (void)loginWithFacebook:(NSString *)email
                 password:(NSString *)password
                    block:(void (^)(NSError *error))block;

- (void)saveFacebookUser:(NSString *)name
                 surname:(NSString *)surname
                   email:(NSString *)email
                birthday:(NSDate *)birthday
               bloodType:(NSString *)bloodType
               thumbnail:(NSString *)thumbnail
                   block:(APIDefaultBlock)block;

- (void)listAllBloodCenters:(void (^)(NSArray *centers, NSError *error))block;

//- (void)saveThumbnail:(UIImage *)image
//           fromPerson:(Person *)person
//                block:(APIDefaultBlock)block;

@end
