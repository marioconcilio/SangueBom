//
//  Person.h
//  SangueBom
//
//  Created by Mario Concilio on 10/27/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSManagedObject

@property (nonatomic, assign) NSString *password;

@end

NS_ASSUME_NONNULL_END

#import "Person+CoreDataProperties.h"
