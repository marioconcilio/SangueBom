//
//  VOBloodCenter.h
//  SangueBom
//
//  Created by Mario Concilio on 11/19/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VOBloodCenter : NSObject

@property (nonatomic, copy) NSString *idCenter;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
