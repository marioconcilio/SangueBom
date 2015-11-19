//
//  SignupViewController.m
//  SangueBom
//
//  Created by Mario Concilio on 9/15/15.
//  Copyright (c) 2015 Mario Concilio. All rights reserved.
//

#import "SignupViewController.h"
#import "MoreInfoViewController.h"
#import <AFViewShaker/AFViewShaker.h>

#define kNameTag    89
#define kSurnameTag 90
#define kEmailTag   91
#define kPassTag    92

@interface SignupViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *surnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end

static NSString *const kMoreInfoSegue = @"moreInfoSegue";

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameTextField.tag = kNameTag;
    self.surnameTextField.tag = kSurnameTag;
    self.emailTextField.tag = kEmailTag;
    self.passwordTextField.tag = kPassTag;
    
    self.nameTextField.delegate = self;
    self.surnameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    self.signupButton.layer.cornerRadius = 5.0;
    self.errorLabel.hidden = YES;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kMoreInfoSegue]) {
        MoreInfoViewController *vc = (MoreInfoViewController *) segue.destinationViewController;
        vc.name = self.nameTextField.text;
        vc.surname = self.surnameTextField.text;
        vc.email = self.emailTextField.text;
        vc.password = self.passwordTextField.text;
    }
}

#pragma mark - Actions
- (IBAction)doSignup:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.nameTextField.text.length == 0 ||
        self.surnameTextField.text.length == 0 ||
        self.emailTextField.text.length == 0 ||
        self.passwordTextField.text.length == 0) {
        [self showError];
        return;
    }
    
    [self performSegueWithIdentifier:kMoreInfoSegue sender:self];
    
//    [KVNProgress show];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [KVNProgress showSuccessWithStatus:@"Conta Criada"];
//    });
}

#pragma mark - Helper Methods
- (void)showError {
    AFViewShaker *shaker = [[AFViewShaker alloc] initWithViewsArray:@[self.nameTextField,
                                                                      self.surnameTextField,
                                                                      self.emailTextField,
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
    if (textField.tag == kPassTag) {
//        [textField resignFirstResponder];
        [self doSignup:nil];
    }
    else {
        UITextField *txt = (UITextField *) [self.view viewWithTag:textField.tag + 1];
        [txt becomeFirstResponder];
    }
    
    return YES;
}

@end
