//
//  WelcomeViewController.m
//  SangueBom
//
//  Created by Mario Concilio on 9/15/15.
//  Copyright (c) 2015 Mario Concilio. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.signupButton.layer.cornerRadius = 5.0;
    self.facebookButton.layer.cornerRadius = 5.0;
    self.loginButton.layer.cornerRadius = 5.0;
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)doFacebookLogin:(UIButton *)sender {
    
}

@end
