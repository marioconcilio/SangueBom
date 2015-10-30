//
//  BloodCenter+CoreDataProperties.h
//  SangueBom
//
//  Created by Mario Concilio on 10/30/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BloodCenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface BloodCenter (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *address;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *phone;

@end

NS_ASSUME_NONNULL_END
