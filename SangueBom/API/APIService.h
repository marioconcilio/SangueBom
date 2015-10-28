//
//  APIService.h
//  SangueBom
//
//  Created by Mario Concilio on 9/16/15.
//  Copyright (c) 2015 Mario Concilio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIService : NSObject

+ (instancetype)sharedInstance;

#pragma mark - Login & Signup Flow
- (void)registerUser:(NSString *)name
             surname:(NSString *)surname
               email:(NSString *)email
            password:(NSString *)password
            birthday:(NSDate *)birthday
           bloodType:(NSString *)bloodType
               block:(void (^)(NSError *error))block;

- (void)login:(NSString *)email
     password:(NSString *)password
        block:(void (^)(NSError *error))block;

- (void)loginWithFacebook:(NSString *)email
                    block:(void (^)(NSError *error))block;

- (void)saveFacebookUser:(NSString *)name
                 surname:(NSString *)surname
                   email:(NSString *)email
                birthday:(NSDate *)birthday
               bloodType:(NSString *)bloodType
               thumbnail:(NSString *)thumbnail
                   block:(void (^)(NSError *error))block;

- (void)truncateAll;

@end
