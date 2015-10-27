//
//  APIService.m
//  SangueBom
//
//  Created by Mario Concilio on 9/16/15.
//  Copyright (c) 2015 Mario Concilio. All rights reserved.
//

#import "APIService.h"
#import "Person.h"
#import "Macros.h"
#import "Helper.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation APIService

static NSString *const kDomain = @"com.marioconcilio.SangueBom";

#pragma mark - Shared Instance
+ (instancetype)sharedInstance {
    static APIService *shared = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    
    return shared;
}

#pragma mark - Private Methods
- (void)saveUserInfo:(Person *)person {
    [Helper saveCustomObject:person forKey:kProfileInfo];
    [NSUserDefaults setObject:person.email forKey:kUserToken];
    [NSUserDefaults synchronize];
}

#pragma mark - Login & Register User Flow
- (void)registerUser:(NSString *)name
             surname:(NSString *)surname
               email:(NSString *)email
            password:(NSString *)password
            birthday:(NSDate *)birthday
           bloodType:(NSString *)bloodType
               block:(void (^)(NSError *error))block {
    __block Person *person = [Person MR_findFirstByAttribute:@"email" withValue:email];
    if (person) {
        block([NSError errorWithDomain:kDomain code:400 userInfo:@{NSLocalizedDescriptionKey: @"email already exists"}]);
        return;
    }
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        person = [Person MR_createEntityInContext:localContext];
        person.name = name;
        person.surname = surname;
        person.email = email;
        person.password = password;
        person.birthday = birthday;
        person.bloodType = bloodType;
    } completion:^(BOOL contextDidSave, NSError *error) {
        if (contextDidSave) {
            [self saveUserInfo:person];
            block(nil);
        }
        else {
            block(error);
        }
    }];
}

- (void)login:(NSString *)email password:(NSString *)password block:(void (^)(NSError *error))block {
    Person *person = [Person MR_findFirstByAttribute:@"email" withValue:email];
    if (person) {
        if ([password isEqualToString:person.password]) {
            [self saveUserInfo:person];
            block(nil);
        }
        else {
            block([NSError errorWithDomain:kDomain code:400 userInfo:@{NSLocalizedDescriptionKey: @"wrong password"}]);
        }
    }
    else {
        block([NSError errorWithDomain:kDomain code:400 userInfo:@{NSLocalizedDescriptionKey: @"wrong email"}]);
    }

}

@end
