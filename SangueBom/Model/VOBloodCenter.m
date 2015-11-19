//
//  VOBloodCenter.m
//  SangueBom
//
//  Created by Mario Concilio on 11/19/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "VOBloodCenter.h"

@implementation VOBloodCenter

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _idCenter = dict[@"ID"];
        _name = dict[@"Nome"];
        _address = dict[@"Endereco"];
        _phone = dict[@"Telefone"];
        _latitude = [dict[@"Latitude"] doubleValue];
        _longitude = [dict[@"Longitude"] doubleValue];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        _idCenter = [decoder decodeObjectForKey:@"ID"];
        _name = [decoder decodeObjectForKey:@"Nome"];
        _address = [decoder decodeObjectForKey:@"Endereco"];
        _phone = [decoder decodeObjectForKey:@"Telefone"];
        _latitude = [[decoder decodeObjectForKey:@"Latitude"] doubleValue];
        _longitude = [[decoder decodeObjectForKey:@"Longitude"] doubleValue];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_idCenter forKey:@"ID"];
    [encoder encodeObject:_name forKey:@"Nome"];
    [encoder encodeObject:_address forKey:@"Endereco"];
    [encoder encodeObject:_phone forKey:@"Telefone"];
    [encoder encodeObject:@(_latitude) forKey:@"Latitude"];
    [encoder encodeObject:@(_longitude) forKey:@"Longitude"];
}

@end
