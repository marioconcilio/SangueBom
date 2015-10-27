//
//  Person+CoreDataProperties.h
//  SangueBom
//
//  Created by Mario Concilio on 10/27/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *birthday;
@property (nullable, nonatomic, retain) NSString *bloodType;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSData *profileImage;
@property (nullable, nonatomic, retain) NSString *surname;

@end

NS_ASSUME_NONNULL_END
