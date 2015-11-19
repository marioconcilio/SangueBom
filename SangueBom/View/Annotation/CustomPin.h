//
//  CustomPin.h
//  SangueBom
//
//  Created by Mario Concilio on 10/29/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#define kCustomPinID    @"CustomPin"

@class VOBloodCenter;
@interface CustomPin : NSObject <MKAnnotation> 

@property (nonatomic) CLLocationCoordinate2D coordinate;;
@property (readonly, nonatomic, copy) NSString *title;
@property (readonly, nonatomic, copy) NSString *subtitle;
@property (readonly, nonatomic, strong) VOBloodCenter *center;

- (instancetype)initWithBloodCenter:(VOBloodCenter *)center;
- (MKAnnotationView *)annotationView;

@end
