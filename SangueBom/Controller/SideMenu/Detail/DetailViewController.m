//
//  DetailViewController.m
//  SangueBom
//
//  Created by Mario Concilio on 11/4/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "Macros.h"
#import "VOBloodCenter.h"
#import "DetailViewController.h"
#import "DetailCell.h"
#import "ParallaxHeaderView.h"
#import <MapKit/MapKit.h>

#define kTitleRow   0
#define kAddressRow 1
#define kPhoneRow   2
#define kDriveRow   3

@interface DetailViewController ()

@end

static NSString *const CellID = @"Cell";

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 38.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    u_int32_t random = arc4random() % 3;
    NSString *imageName = [NSString stringWithFormat:@"%d.jpg", random+1];
    ParallaxHeaderView *headerView = [ParallaxHeaderView parallaxHeaderViewWithImage:[UIImage imageNamed:imageName]
                                                                             forSize:CGSizeMake(UIKeyWindowWidth, 200)];
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"close"] style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [(ParallaxHeaderView *)self.tableView.tableHeaderView refreshBlurViewForNewImage];
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Helper Methods
- (void)makeCall {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ligar"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       [self openPhone];
                                                   }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancelar"
                                                           style:UIAlertActionStyleCancel
                                                         handler:NULL];
    
    [alertController addAction:action];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:NULL];
}

- (void)goDrive {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Traçar Rota"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       [self openMaps];
                                                   }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancelar"
                                                           style:UIAlertActionStyleCancel
                                                         handler:NULL];
    
    [alertController addAction:action];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:NULL];
}

- (void)openPhone {
    NSString *phoneNumber = [@"tel://" stringByAppendingString:self.bloodCenter.phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

- (void)openMaps {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.bloodCenter.latitude, self.bloodCenter.longitude);
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                   addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.bloodCenter.name;
    
    MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
    
    [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem]
                   launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving}];
}

#pragma mark - Scroll View Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [(ParallaxHeaderView *)self.tableView.tableHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
}

#pragma mark - Table View Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case kTitleRow:
            cell.detailLabel.text = self.bloodCenter.name;
            cell.detailImage.image = [UIImage imageNamed:@"sgb_name"];
            break;
            
        case kAddressRow:
            cell.detailLabel.text = self.bloodCenter.address;
            cell.detailImage.image = [UIImage imageNamed:@"sgb_address"];
            break;
            
        case kPhoneRow:
            cell.detailLabel.text = self.bloodCenter.phone;
            cell.detailImage.image = [UIImage imageNamed:@"sgb_phone"];
            break;
            
        case kDriveRow:
            cell.detailLabel.text = @"Ir";
            cell.detailImage.image = [UIImage imageNamed:@"sgb_drive"];
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case kPhoneRow:
            [self makeCall];
            break;
            
        case kDriveRow:
            [self goDrive];
            break;
            
        default:
            NSLog(@"tapped cell at %ld", indexPath.row);
            break;
    }
}

@end
