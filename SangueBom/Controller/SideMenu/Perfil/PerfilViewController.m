//
//  PerfilViewController.m
//  SangueBom
//
//  Created by Mario Concilio on 10/26/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "PerfilViewController.h"
#import "AppDelegate.h"
#import "VOUser.h"
#import "Helper.h"
#import "Constants.h"
#import "UIViewController+BaseViewController.h"
#import "UIFont+CustomFont.h"
#import "UIColor+CustomColor.h"
#import "APIService.h"
#import "DBCameraViewController.h"
#import "DBCameraContainerViewController.h"
#import "FadeInNavigationController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface PerfilViewController () <DBCameraViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *bloodTypeLabel;
@property (weak, nonatomic) IBOutlet UIButton *changePictureButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@end

@implementation PerfilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addDrawerButton];
    
    [self.changePictureButton addTarget:self action:@selector(doChangePicture:) forControlEvents:UIControlEventTouchUpInside];
    [self.logoutButton addTarget:self action:@selector(doLogout:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    VOUser *user = [Helper loadUser];
    self.nameLabel.text = [NSString stringWithFormat:@"%@", user.name];
    self.emailLabel.text = user.email;
    self.birthdayLabel.text = user.birthday;
    self.bloodTypeLabel.text = user.bloodType;
    
    [Helper avatarFromName:self.nameLabel.text font:[UIFont customUltraLightFontWithSize:38.0] diameter:120.0 callback:^(UIImage *image) {
//        if (user.thumbnail) {
//            NSURL *url;
//            if ([person.thumbnail hasPrefix:@"http"]) {
//                url = [NSURL URLWithString:person.thumbnail];
//            }
//            else {
//                url = [NSURL fileURLWithPath:[person.thumbnail stringByExpandingTildeInPath]];
//            }
//            
//            [self.profileImageView setImageWithURL:url placeholderImage:image];
//        }
//        else {
            self.profileImageView.image = image;
//        }
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.profileImageView.layer.cornerRadius = CGRectGetHeight(self.profileImageView.frame)/2;
    self.profileImageView.layer.borderColor = [UIColor customOrange].CGColor;
    self.profileImageView.layer.borderWidth = 1.0;
    self.profileImageView.clipsToBounds = YES;
    
    self.changePictureButton.layer.cornerRadius = 5.0;
    self.logoutButton.layer.cornerRadius = 5.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Methods
- (void)doChangePicture:(UIButton *)sender {
    DBCameraViewController *cameraController = [DBCameraViewController initWithDelegate:self];
    [cameraController setForceQuadCrop:YES];
    [cameraController setUseCameraSegue:YES];
    
    DBCameraContainerViewController *container = [[DBCameraContainerViewController alloc] initWithDelegate:self];
    [container setCameraViewController:cameraController];
    [container setFullScreenMode];
    
    FadeInNavigationController *nav = [[FadeInNavigationController alloc] initWithRootViewController:container];
    [nav setNavigationBarHidden:YES];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)doLogout:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Logout"
                                                                             message:@"Deseja sair da sua conta?"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Logout"
                                                     style:UIAlertActionStyleDestructive
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       [NSUserDefaults setObject:nil forKey:kUserToken];
                                                       [UIAppDelegate defineRootViewControllerAnimated:YES];                                                   }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancelar"
                                                           style:UIAlertActionStyleCancel
                                                         handler:NULL];
    
    [alertController addAction:action];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:NULL];
}

#pragma mark - DBCameraViewControllerDelegate
- (void)camera:(id)cameraViewController didFinishWithImage:(UIImage *)image withMetadata:(NSDictionary *)metadata {
    dispatch_async(dispatch_get_main_queue(), ^{
//        [[APIService sharedInstance] saveThumbnail:image fromPerson:[Helper loadUser] block:^(NSError *error) {
//            self.profileImageView.image = image;
//        }];
    });
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    
    NSString *source = [metadata objectForKey:@"DBCameraSource"];
    if( [source hasSuffix:@"Camera"] ){
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
}

-(void)dismissCamera:(id)cameraViewController {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [self dismissViewControllerAnimated:YES completion:nil];
    [cameraViewController restoreFullScreenMode];
}

@end
