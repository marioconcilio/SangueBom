//
//  WelcomeViewController.m
//  SangueBom
//
//  Created by Mario Concilio on 9/15/15.
//  Copyright (c) 2015 Mario Concilio. All rights reserved.
//

#import "WelcomeViewController.h"
#import "AppDelegate.h"
#import "Macros.h"
#import "ApiService.h"
#import "MoreInfoViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <KVNProgress.h>

@interface WelcomeViewController () <FBSDKGraphRequestConnectionDelegate>

@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation WelcomeViewController

static NSString *const kMoreInfoSegue = @"moreInfoSegue";

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
//    [KVNProgress show];
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"email", @"public_profile"]
                 fromViewController:nil
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                [self loginWithResult:result error:error];
                            }];
}

- (void)loginWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    if (error) {
        NSLog(@"%@", error.description);
    }
    else if (result.isCancelled ) {
        NSLog(@"cancelled by user");
    }
    else {
        NSDictionary *params = @{@"fields": @"id, first_name, last_name, email, picture.height(400).width(400)"};
        FBSDKGraphRequest *requestMe = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                                                         parameters:params
                                                                         HTTPMethod:@"GET"];
        
        FBSDKGraphRequestConnection *connection = [[FBSDKGraphRequestConnection alloc] init];
        [connection addRequest:requestMe
             completionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 NSDictionary *responseObject = (NSDictionary *)result;
                 
                 NSString *email = [responseObject[@"email"] stringByAppendingString:@".facebook"];
                 [[APIService sharedInstance] loginWithFacebook:email password:responseObject[@"id"] block:^(NSError *error) {
                     if (error) {
                         [self performSegueWithIdentifier:kMoreInfoSegue sender:result];
                     }
                     else {
                         [UIAppDelegate defineRootViewControllerAnimated:YES];
                     }
                 }];
                 
             }];
        
        connection.delegate = self;
        [connection start];
    }
}

#pragma mark - FBSDK Graph Request Connection
- (void)requestConnectionDidFinishLoading:(FBSDKGraphRequestConnection *)connection {
//    [UIAppDelegate defineRootViewControllerAnimated:YES];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kMoreInfoSegue]) {
        MoreInfoViewController *vc = segue.destinationViewController;
        NSDictionary *dict = (NSDictionary *)sender;
        vc.name = dict[@"first_name"];
        vc.surname = dict[@"last_name"];
        vc.email = dict[@"email"];
        vc.thumb = dict[@"picture"][@"data"][@"url"];
    }
}

@end
