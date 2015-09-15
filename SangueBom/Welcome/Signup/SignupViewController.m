//
//  SignupViewController.m
//  SangueBom
//
//  Created by Mario Concilio on 9/15/15.
//  Copyright (c) 2015 Mario Concilio. All rights reserved.
//

#import "SignupViewController.h"

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

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Criar Conta";
    
    self.nameTextField.tag = kNameTag;
    self.surnameTextField.tag = kSurnameTag;
    self.emailTextField.tag = kEmailTag;
    self.passwordTextField.tag = kPassTag;
    
    self.nameTextField.delegate = self;
    self.surnameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    self.signupButton.layer.cornerRadius = 5.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)doSignup:(UIButton *)sender {
    
}

#pragma mark - TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == kPassTag) {
        [textField resignFirstResponder];
    }
    else {
        UITextField *txt = (UITextField *) [self.view viewWithTag:textField.tag + 1];
        [txt becomeFirstResponder];
    }
    
    return YES;
}

@end
