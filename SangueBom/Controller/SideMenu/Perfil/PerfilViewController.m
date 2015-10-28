//
//  PerfilViewController.m
//  SangueBom
//
//  Created by Mario Concilio on 10/26/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "PerfilViewController.h"
#import "AppDelegate.h"
#import "Person.h"
#import "Helper.h"
#import "UIViewController+BaseViewController.h"
#import "UIFont+CustomFont.h"
#import "UIColor+CustomColor.h"
#import <NYAlertViewController.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface PerfilViewController ()

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
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    Person *person = [Helper loadUser];
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", person.name, person.surname];
    self.emailLabel.text = person.email;
    self.birthdayLabel.text = [formatter stringFromDate:person.birthday];
    self.bloodTypeLabel.text = person.bloodType;
    
    [Helper avatarFromName:self.nameLabel.text font:[UIFont customUltraLightFontWithSize:34.0] diameter:120.0 callback:^(UIImage *image) {
        [self.profileImageView setImageWithURL:[NSURL URLWithString:person.thumbnail] placeholderImage:image];
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
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

-(void)doLogout:(UIButton *)sender {
    NYAlertViewController *alert = [[NYAlertViewController alloc] init];
    alert.backgroundTapDismissalGestureEnabled = YES;
    alert.buttonCornerRadius = 10.0;
    alert.view.tintColor = [UIColor customDarkBackground];
    alert.titleFont = [UIFont customBoldFontWithSize:17.0];
    alert.messageFont = [UIFont customLightFontWithSize:17.0];
    alert.buttonTitleFont = [UIFont customRegularFontWithSize:17.0];
    alert.cancelButtonTitleFont = [UIFont customRegularFontWithSize:17.0];
    alert.destructiveButtonTitleFont = [UIFont customMediumFontWithSize:17.0];
    alert.destructiveButtonColor = [UIColor customRed];
    alert.title = @"Atenção";
    alert.message = @"Deseja fazer logout?";
    
    [alert addAction:[NYAlertAction actionWithTitle:@"Logout"
                                              style:UIAlertActionStyleDestructive
                                            handler:^(NYAlertAction *action) {
                                                [NSUserDefaults setObject:nil forKey:kUserToken];
                                                [UIAppDelegate defineRootViewControllerAnimated:YES];
                                            }]];
    
    [alert addAction:[NYAlertAction actionWithTitle:@"Cancelar"
                                              style:UIAlertActionStyleCancel
                                            handler:^(NYAlertAction *action) {
                                                [self dismissViewControllerAnimated:YES completion:NULL];
                                            }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}

@end
