//
//  APIService.m
//  SangueBom
//
//  Created by Mario Concilio on 9/16/15.
//  Copyright (c) 2015 Mario Concilio. All rights reserved.
//

#import "APIService.h"
#import "Macros.h"
#import "Helper.h"
#import "Constants.h"
#import "VOUser.h"
#import "VOBloodCenter.h"
#import <UIKit/UIKit.h>
#import <MagicalRecord/MagicalRecord.h>
#import <AFNetworking/AFNetworking.h>

@implementation APIService

static NSString *const kDomain = @"com.marioconcilio.SangueBom";
static NSString *const kBaseURL = @"http://treinamentomobiledev.tfo.com.br/integracao";

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
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    if (auth) {
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"x"
                                                                  password:[NSUserDefaults objectForKey:kUserToken]];
    }
    
    return manager;
}

- (void)saveUserInfo:(NSDictionary *)dictionary {
    VOUser *user = [[VOUser alloc] initWithDictionary:dictionary];
    [Helper saveCustomObject:user forKey:kProfileInfo];
    [NSUserDefaults setObject:user.email forKey:kUserToken];
    [NSUserDefaults synchronize];
}

#pragma mark - Login & Register User Flow
- (void)registerUser:(NSString *)name email:(NSString *)email password:(NSString *)password bloodType:(NSString *)bloodType birthday:(NSString *)birthday block:(APIDefaultBlock)block {
    NSDictionary *parameters = @{@"nome": name,
                                 @"email": email,
                                 @"senha": password,
                                 @"tiposanguineo": bloodType,
                                 @"dtNascimento": birthday};
    
    NSString *url = [kBaseURL stringByAppendingString:@"/WsSBCriacaoUsuario"];
    AFHTTPSessionManager *manager = [self managerWithAuth:NO];
    
    [manager POST:url
       parameters:parameters
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
              NSString *code = responseObject;
              if ([code isEqualToString:@"200"]) {
                  NSDictionary *dict = @{@"ID": @"666",
                                         @"Nome": name,
                                         @"Email": email,
                                         @"TipoSanguineo": bloodType,
                                         @"dtNascimentoFormatada": birthday};
                  [self saveUserInfo:dict];
                  block(nil);
              }
              else {
                  block([NSError errorWithDomain:kDomain code:404 userInfo:nil]);
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              block(error);
              NSLog(@"%@", error);
          }];
}

- (void)login:(NSString *)email password:(NSString *)password block:(APIDefaultBlock)block {
    NSDictionary *parameters = @{@"email": email,
                                 @"senha": password};
    
    NSString *url = [kBaseURL stringByAppendingString:@"/WsSBLoginUsuario"];
    AFHTTPSessionManager *manager = [self managerWithAuth:NO];
    
    [manager POST:url
       parameters:parameters
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
              if ([responseObject isKindOfClass:[NSDictionary class]]) {
                  NSDictionary *dict = responseObject;
                  [self saveUserInfo:dict];
                  block(nil);
              }
              else {
                  block([NSError errorWithDomain:kDomain code:404 userInfo:nil]);
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              block(error);
              NSLog(@"%@", error);
          }];
}

- (void)updateUserBloodType:(NSString *)bloodType email:(NSString *)email password:(NSString *)password block:(APIDefaultBlock)block {
    VOUser *user = [Helper loadUser];
    NSDictionary *parameters = @{@"nome": user.name,
                                 @"email": email,
                                 @"senha": password,
                                 @"tiposanguineo": bloodType,
                                 @"dtNascimento": user.birthday};
    
    NSString *url = [kBaseURL stringByAppendingString:@"/WsSBAtualizacaoUsuario"];
    AFHTTPSessionManager *manager = [self managerWithAuth:NO];
    
    [manager POST:url
       parameters:parameters
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
              if ([responseObject isEqualToString:@"200"]) {
                  NSDictionary *dict = @{@"ID": @"666",
                                         @"Nome": user.name,
                                         @"Email": email,
                                         @"TipoSanguineo": bloodType,
                                         @"dtNascimentoFormatada": user.birthday};
                  [self saveUserInfo:dict];
                  block(nil);
              }
              else {
                  block([NSError errorWithDomain:kDomain code:404 userInfo:nil]);
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              block(error);
              NSLog(@"%@", error);
          }];
}

- (void)loginWithFacebook:(NSString *)email password:(NSString *)password block:(APIDefaultBlock)block {
    [self login:email password:password block:^(NSError *error) {
        
    }];
    
//    Person *person = [Person MR_findFirstByAttribute:@"email" withValue:email];
//    if (person) {
//        [self saveUserInfo:email];
//        block(nil);
//    }
//    else {
//        block([NSError errorWithDomain:kDomain code:400 userInfo:@{NSLocalizedDescriptionKey: @"wrong email"}]);
//    }
}

- (void)saveFacebookUser:(NSString *)name
                 surname:(NSString *)surname
                   email:(NSString *)email
                birthday:(NSDate *)birthday
               bloodType:(NSString *)bloodType
               thumbnail:(NSString *)thumbnail
                   block:(APIDefaultBlock)block {
    
//    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
//        Person *newPerson = [Person MR_createEntityInContext:localContext];
//        
//        newPerson.name = name;
//        newPerson.surname = surname;
//        newPerson.email = email;
//        newPerson.birthday = birthday;
//        newPerson.bloodType = bloodType;
//        newPerson.thumbnail = thumbnail;
//    } completion:^(BOOL contextDidSave, NSError *error) {
//        if (contextDidSave) {
//            [self saveUserInfo:email];
//            block(nil);
//        }
//        else {
//            block(error);
//        }
//    }];
    
}

//- (void)saveThumbnail:(UIImage *)image fromPerson:(Person *)person block:(APIDefaultBlock)block {
//    NSData *imageData = UIImagePNGRepresentation(image);
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = paths[0];
//    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", person.email]];
//    [fileManager createFileAtPath:fullPath contents:imageData attributes:nil];
//    
//    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
//        Person *newPerson = [person MR_inContext:localContext];
//        newPerson.thumbnail = fullPath;
//    } completion:^(BOOL contextDidSave, NSError *error) {
//        if (contextDidSave) {
//            block(nil);
//        }
//        else {
//            block(error);
//            NSLog(@"%@", error);
//        }
//    }];
//}

#pragma mark - List Blood Centers
- (void)listAllBloodCenters:(void (^)(NSArray *, NSError *))block {
    NSString *url = [NSString stringWithFormat:@"%@/WsSBListaHemocentro", kBaseURL];
    AFHTTPSessionManager *manager = [self managerWithAuth:NO];
    
    [manager GET:url
      parameters:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
             if ([responseObject isKindOfClass:[NSArray class]]) {
                 NSArray *resp = responseObject;
                 NSMutableArray *centers = [NSMutableArray arrayWithCapacity:resp.count];
                 @autoreleasepool {
                     for (NSDictionary *dict in resp) {
                         VOBloodCenter *center = [[VOBloodCenter alloc] initWithDictionary:dict];
                         [centers addObject:center];
                     }
                 }
                 
                 block(centers, nil);
             }
             else {
                 block(nil, [NSError errorWithDomain:kDomain code:404 userInfo:nil]);
             }
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             block(nil, error);
             NSLog(@"%@", error);
         }];
}

@end
