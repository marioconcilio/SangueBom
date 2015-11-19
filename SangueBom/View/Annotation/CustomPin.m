//
//  CustomPin.m
//  SangueBom
//
//  Created by Mario Concilio on 10/29/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "CustomPin.h"
#import "VOBloodCenter.h"

#define kPinHeight  60.0
#define kPinWidth   60.0

@interface CustomPin () {
@private
    NSString *_title;
    NSString *_subtitle;
    VOBloodCenter *_bloodCenter;
}

@end

@implementation CustomPin

- (instancetype)initWithBloodCenter:(VOBloodCenter *)center {
    if (self == [super init]) {
        _center = center;
        _coordinate = CLLocationCoordinate2DMake(center.latitude, center.longitude);
        _title = center.name;
        _subtitle = center.address;
    }
    
    return self;
}

- (MKAnnotationView *)annotationView {
    MKAnnotationView *annView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:kCustomPinID];
    annView.canShowCallout = YES;
    annView.calloutOffset = CGPointMake(0.0, -kPinHeight+5.0);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeInfoLight];
//    btn.userInteractionEnabled = NO;
    annView.rightCalloutAccessoryView = btn;
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(-kPinWidth/2,
                                                                 -kPinHeight,
                                                                 kPinWidth,
                                                                 kPinHeight)];
    
    UIImageView *pin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sgb_pin"]];
    pin.frame = CGRectMake(0, 8, kPinWidth, kPinHeight);
    
    [container addSubview:pin];
    [annView addSubview:container];
    
    return annView;
}

@end

