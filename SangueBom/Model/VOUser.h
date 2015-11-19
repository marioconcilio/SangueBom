//
//  VOUser.h
//  SangueBom
//
//  Created by Mario Concilio on 11/19/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VOUser : NSObject

@property (nonatomic, copy) NSString *idUser;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *bloodType;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *thumbnail;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
