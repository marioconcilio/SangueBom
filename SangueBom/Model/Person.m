//
//  Person.m
//  SangueBom
//
//  Created by Mario Concilio on 10/27/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "Person.h"
#import <SSKeychain.h>

@implementation Person

static NSString *const SERVICE = @"com.marioconcilio.SangueBom";

- (NSString *)password {
    if (self.email) {
        return [SSKeychain passwordForService:SERVICE account:self.email];
    }
    
    return nil;
}

- (void)setPassword:(NSString *)password {
    if (self.email) {
        [SSKeychain setPassword:password forService:SERVICE account:self.email];
    }
}

- (void)prepareForDeletion {
    if (self.email) {
        [SSKeychain deletePasswordForService:SERVICE account:self.email];
    }
}

@end
