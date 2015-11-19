//
//  VOUser.m
//  SangueBom
//
//  Created by Mario Concilio on 11/19/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "VOUser.h"

@implementation VOUser

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _idUser = dict[@"ID"];
        _name = dict[@"Nome"];
        _email = dict[@"Email"];
        _bloodType = dict[@"TipoSanguineo"];
        _birthday = dict[@"dtNascimentoFormatada"];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        _idUser = [decoder decodeObjectForKey:@"ID"];
        _name = [decoder decodeObjectForKey:@"Nome"];
        _email = [decoder decodeObjectForKey:@"Email"];
        _bloodType = [decoder decodeObjectForKey:@"TipoSanguineo"];
        _birthday = [decoder decodeObjectForKey:@"dtNascimentoFormatada"];
        _thumbnail = [decoder decodeObjectForKey:@"thumbnail"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_idUser forKey:@"ID"];
    [encoder encodeObject:_name forKey:@"Nome"];
    [encoder encodeObject:_email forKey:@"Email"];
    [encoder encodeObject:_bloodType forKey:@"TipoSanguineo"];
    [encoder encodeObject:_birthday forKey:@"dtNascimentoFormatada"];
    [encoder encodeObject:_thumbnail forKey:@"thumbnail"];
}

@end
