//
//  MapViewController.m
//  SangueBom
//
//  Created by Mario Concilio on 10/26/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "MapViewController.h"
#import "Macros.h"
#import "UIViewController+BaseViewController.h"
#import <MapKit/MapKit.h>

#define kButtonSize         45
#define kMarginInset        10
#define kCompassViewTag     89
#define kCompassButtonTag   66

@interface MapViewController () <CLLocationManagerDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (assign, nonatomic, getter=isTrackingUser) BOOL trackingUser;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addDrawerButton];
    [self setupCompassButton];
    [self setupCameraAndLocationManager];
    [self setupGestures];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup Methods
- (void)setupCompassButton {
    CGFloat viewWidth = CGRectGetWidth(UIKeyWindow.bounds);
    CGFloat viewHeight = CGRectGetHeight(UIKeyWindow.bounds);
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIView *buttonView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    buttonView.frame = CGRectMake(viewWidth - kButtonSize - kMarginInset,
                                  viewHeight - kButtonSize - kMarginInset,
                                  kButtonSize,
                                  kButtonSize);
    buttonView.layer.borderWidth = 1.0;
    buttonView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    buttonView.layer.cornerRadius = 4.0;
    buttonView.clipsToBounds = YES;
    buttonView.tag = kCompassViewTag;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kButtonSize, kButtonSize)];
    [button setImage:[UIImage imageNamed:@"sgb_compass_on"] forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(didTrackingButton:)
     forControlEvents:UIControlEventTouchUpInside];
    button.tag = kCompassButtonTag;
    [buttonView addSubview:button];
    [self.mapView addSubview:buttonView];
}

- (void)setupCameraAndLocationManager {
    self.mapView.showsUserLocation = YES;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    
    self.trackingUser = YES;
    [self.locationManager startUpdatingLocation];
    
    CLLocation *location = self.locationManager.location;
    CLLocationCoordinate2D coordinate = location.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [self.mapView setRegion:region];
}

- (void)setupGestures {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(panGestureOnMap:)];
    panGesture.delegate = self;
    [self.mapView addGestureRecognizer:panGesture];
}

#pragma mark - Setter Methods
- (void)setTrackingUser:(BOOL)trackingUser {
    _trackingUser = trackingUser;
    
    UIView *view = [self.view viewWithTag:kCompassViewTag];
    UIButton *button = (UIButton *) [view viewWithTag:kCompassButtonTag];
    
    if (trackingUser) {
        MKMapCamera *newCamera = [self.mapView.camera copy];
        newCamera.centerCoordinate = self.locationManager.location.coordinate;
        newCamera.heading = self.locationManager.location.course;
        [self.mapView setCamera:newCamera animated:YES];
        
        [button setImage:[UIImage imageNamed:@"sgb_compass_on"] forState:UIControlStateNormal];
    }
    else {
        [button setImage:[UIImage imageNamed:@"sgb_compass_off"] forState:UIControlStateNormal];
    }
}

#pragma mark - Action
- (void)didTrackingButton:(UIButton *)sender {
    if ([self isTrackingUser]) {
        [self setTrackingUser:NO];
    }
    else {
        [self setTrackingUser:YES];
    }
}

#pragma mark - Gesture Methods
- (void)panGestureOnMap:(UIPanGestureRecognizer *)gesture {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([self isTrackingUser]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTrackingUser:NO];
            });
        }
    });
}

#pragma mark - Delegates
#pragma mark - Gesture Recognizer Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - CLLocationManager Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if ([self isTrackingUser]) {
        CLLocation *location = [locations lastObject];
        
        MKMapCamera *newCamera = [self.mapView.camera copy];
        newCamera.centerCoordinate = location.coordinate;
        newCamera.heading = location.course;
        [self.mapView setCamera:newCamera animated:YES];
    }
}

@end
