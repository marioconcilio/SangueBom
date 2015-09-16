//
//  APIService.m
//  SangueBom
//
//  Created by Mario Concilio on 9/16/15.
//  Copyright (c) 2015 Mario Concilio. All rights reserved.
//

#import "APIService.h"
#import <AFNetworking/AFNetworking.h>

#define kBaseURL        @"http://ec2-54-94-252-195.sa-east-1.compute.amazonaws.com"
#define kUserToken      @"user_token"
#define kProfileInfo    @"profile_info"
#define NSUserDefaults  [NSUserDefaults standardUserDefaults]

@implementation APIService

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
- (AFHTTPSessionManager *)managerWithAuth:(BOOL)auth {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if (auth) {
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"x" password:[NSUserDefaults objectForKey:kUserToken]];
    }
    
    return manager;
}

//- (void)saveUserInfo:(NSDictionary *)dictionary {
//    VOUser *user = [[VOUser alloc] initWithDictionary:dictionary];
//    [Helper saveCustomObject:user forKey:kProfileInfo];
//    [NSUserDefaults setObject:[dictionary objectForKey:@"student_hash"] forKey:kUserToken];
//    [NSUserDefaults synchronize];
//}

#pragma mark - Login & Register User Flow
- (void)registerUser:(NSString *)name email:(NSString *)email password:(NSString *)password block:(void (^)(NSError *error))block {
    NSDictionary *parameters = @{@"name": name,
                                 @"email": email,
                                 @"password": password};
    
    NSString *url = [NSString stringWithFormat:@"%@/student", kBaseURL];
    AFHTTPSessionManager *manager = [self managerWithAuth:NO];
    
    [manager POST:url
       parameters:parameters
          success:^(NSURLSessionDataTask *operation, id responseObject) {
              NSDictionary *response = (NSDictionary *)responseObject;
              if (![[response valueForKey:@"error"] boolValue]) {
//                  [self saveUserInfo:response];
                  block(nil);
              }
              else {
                  NSInteger statusCode = [[response valueForKey:@"status_code"] integerValue];
                  NSDictionary *info = @{NSLocalizedDescriptionKey: [response valueForKey:@"message"]};
                  block([NSError errorWithDomain:@"Fanta" code:statusCode userInfo:info]);
              }
          }
          failure:^(NSURLSessionDataTask *operation, NSError *error) {
              block(error);
              NSLog(@"%@", error.debugDescription);
          }];
}

- (void)login:(NSString *)email password:(NSString *)password block:(void (^)(NSError *error))block {
    NSDictionary *parameters = @{@"password": password,
                                 @"email": email};
    
    NSString *url = [NSString stringWithFormat:@"%@/login", @"asd"];
    
    AFHTTPSessionManager *manager = [self managerWithAuth:NO];
    
    [manager POST: url
       parameters:parameters
          success:^(NSURLSessionDataTask *operation, id responseObject) {
              NSDictionary *response = (NSDictionary *)responseObject;
              if (![[response valueForKey: @"error"] boolValue]) {
//                  [self saveUserInfo:response];
                  block(nil);
              }
              else {
                  NSInteger statusCode = [[response valueForKey:@"status_code"] integerValue];
                  NSDictionary *info = @{NSLocalizedDescriptionKey: [response valueForKey:@"message"]};
                  block([NSError errorWithDomain:@"Fanta" code:statusCode userInfo:info]);
              }
          }
          failure:^(NSURLSessionDataTask *operation, NSError *error) {
              block(error);
              NSLog(@"%@", error.debugDescription);
          }];
}

@end
