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
               email:(NSString *)email
            password:(NSString *)password
               block:(void (^)(NSError *error))block;

- (void)login:(NSString *)email
     password:(NSString *)password
        block:(void (^)(NSError *error))block;

@end
