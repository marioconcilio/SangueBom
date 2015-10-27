//
//  LoginViewController.m
//  SangueBom
//
//  Created by Mario Concilio on 9/15/15.
//  Copyright (c) 2015 Mario Concilio. All rights reserved.
//

#import "APIService.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "Macros.h"
#import <AFViewShaker/AFViewShaker.h>
#import <KVNProgress/KVNProgress.h>

#define kEmailTag   89
#define kPassTag    90

@interface LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emailTextField.tag = kEmailTag;
    self.passwordTextField.tag = kPassTag;
    
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    self.loginButton.layer.cornerRadius = 5.0;
    self.errorLabel.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)doLogin:(UIButton *)sender {
    [self.view endEditing:YES];
    
    if (self.emailTextField.text.length == 0 || self.passwordTextField.text.length == 0) {
        [self showError];
        return;
    }
    
//    [KVNProgress show];
    
    [[APIService sharedInstance] login:self.emailTextField.text
                              password:self.passwordTextField.text
                                 block:^(NSError *error) {
//                                     [KVNProgress dismiss];
                                     
                                     if (error) {
                                         NSLog(@"code: %ld, %@", error.code, error.userInfo[NSLocalizedDescriptionKey]);
                                         [self showError];
                                     }
                                     else {
                                         self.errorLabel.hidden = YES;
                                         [UIAppDelegate defineRootViewControllerAnimated:YES];
                                     }
                                 }];
}

#pragma mark - Helper Methods
- (void)showError {
    AFViewShaker *shaker = [[AFViewShaker alloc] initWithViewsArray:@[self.emailTextField,
                                                                      self.passwordTextField]];
    [shaker shake];
    
    [UIView transitionWithView:self.errorLabel
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.errorLabel.hidden = NO;
                    }
                    completion:NULL];
}

#pragma mark - TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == kEmailTag) {
        [self.passwordTextField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

@end
