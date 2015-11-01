//
//  APIService.m
//  SangueBom
//
//  Created by Mario Concilio on 9/16/15.
//  Copyright (c) 2015 Mario Concilio. All rights reserved.
//

#import "APIService.h"
#import "Person.h"
#import "BloodCenter.h"
#import "Macros.h"
#import "Helper.h"
#import "Constants.h"
#import <UIKit/UIKit.h>
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
- (void)saveUserInfo:(NSString *)email {
//    [Helper saveCustomObject:person forKey:kProfileInfo];
    [NSUserDefaults setObject:email forKey:kUserToken];
    [NSUserDefaults synchronize];
}

#pragma mark - Login & Register User Flow
- (void)registerUser:(NSString *)name
             surname:(NSString *)surname
               email:(NSString *)email
            password:(NSString *)password
            birthday:(NSDate *)birthday
           bloodType:(NSString *)bloodType
               block:(APIDefaultBlock)block {
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
            [self saveUserInfo:email];
            block(nil);
        }
        else {
            block(error);
        }
    }];
}

- (void)login:(NSString *)email password:(NSString *)password block:(APIDefaultBlock)block {
    Person *person = [Person MR_findFirstByAttribute:@"email" withValue:email];
    if (person) {
        if ([password isEqualToString:person.password]) {
            [self saveUserInfo:email];
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

- (void)loginWithFacebook:(NSString *)email block:(APIDefaultBlock)block {
    Person *person = [Person MR_findFirstByAttribute:@"email" withValue:email];
    if (person) {
        [self saveUserInfo:email];
        block(nil);
    }
    else {
        block([NSError errorWithDomain:kDomain code:400 userInfo:@{NSLocalizedDescriptionKey: @"wrong email"}]);
    }
}

- (void)saveFacebookUser:(NSString *)name
                 surname:(NSString *)surname
                   email:(NSString *)email
                birthday:(NSDate *)birthday
               bloodType:(NSString *)bloodType
               thumbnail:(NSString *)thumbnail
                   block:(APIDefaultBlock)block {
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        Person *newPerson = [Person MR_createEntityInContext:localContext];
        
        newPerson.name = name;
        newPerson.surname = surname;
        newPerson.email = email;
        newPerson.birthday = birthday;
        newPerson.bloodType = bloodType;
        newPerson.thumbnail = thumbnail;
    } completion:^(BOOL contextDidSave, NSError *error) {
        if (contextDidSave) {
            [self saveUserInfo:email];
            block(nil);
        }
        else {
            block(error);
        }
    }];
    
}

- (void)truncateAllPersons:(APIDefaultBlock)block {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        [Person MR_truncateAllInContext:localContext];
    } completion:^(BOOL contextDidSave, NSError *error) {
        if (contextDidSave) {
            [NSUserDefaults setObject:nil forKey:kUserToken];
        }
        else {
            block(error);
        }
    }];
}

- (void)truncateAllBloodCenters:(APIDefaultBlock)block {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        [BloodCenter MR_truncateAllInContext:localContext];
    } completion:^(BOOL contextDidSave, NSError *error) {
        block(error);
    }];
}

- (void)saveThumbnail:(UIImage *)image fromPerson:(Person *)person block:(APIDefaultBlock)block {
    NSData *imageData = UIImagePNGRepresentation(image);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", person.email]];
    [fileManager createFileAtPath:fullPath contents:imageData attributes:nil];
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        Person *newPerson = [person MR_inContext:localContext];
        newPerson.thumbnail = fullPath;
    } completion:^(BOOL contextDidSave, NSError *error) {
        if (contextDidSave) {
            block(nil);
        }
        else {
            block(error);
        }
    }];
}

#pragma mark - List Blood Centers
- (void)bloodCenters:(void (^)(NSArray *centers))block {
    NSArray *centers = [BloodCenter MR_findAll];
    block(centers);
}

#pragma mark - Populate Blood Centers
- (void)populateBloodCenters:(APIDefaultBlock)block {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        BloodCenter *b1 = [BloodCenter MR_createEntityInContext:localContext];
        b1.name = @"Fundação Pró-Sangue Hemocentro de São Paulo - Posto Barueri";
        b1.address = @"R. Angela Mirella, 354 Térreo - Jardim Barueri - Barueri";
        b1.phone = @"0800-55-0300";
        b1.latitude = -23.496635;
        b1.longitude = -46.872825;
        
        BloodCenter *b2 = [BloodCenter MR_createEntityInContext:localContext];
        b2.name = @"Fundação Pró-Sangue Hemocentro de São Paulo - Posto Clínicas";
        b2.address = @"Av. Enéas Carvalho Aguiar, 155 1º andar - Cerqueira César - São Paulo";
        b2.phone = @"0800-55-0300";
        b2.latitude = -23.557110;
        b2.longitude = -46.668857;
        
        BloodCenter *b3 = [BloodCenter MR_createEntityInContext:localContext];
        b3.name = @"Fundação Pró-Sangue Hemocentro de São Paulo - Posto Dante Pazzanese";
        b3.address = @"Av. Doutor Dante Pazzanese, 500 - Ibirapuera - São Paulo";
        b3.phone = @"0800-55-0300";
        b3.latitude = -23.585106;
        b3.longitude = -46.652241;
        
        BloodCenter *b4 = [BloodCenter MR_createEntityInContext:localContext];
        b4.name = @"Fundação Pró-Sangue Hemocentro de São Paulo - Posto Mandaqui";
        b4.address = @"R. Voluntários da Pátria, 4227 - Mandaqui - São Paulo";
        b4.phone = @"0800-55-0300";
        b4.latitude = -23.484512;
        b4.longitude = -46.630251;
    } completion:^(BOOL contextDidSave, NSError *error) {
        block(error);
    }];;
}

@end
