//
//  MoreInfoViewController.m
//  SangueBom
//
//  Created by Mario Concilio on 10/26/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "MoreInfoViewController.h"
#import "APIService.h"
#import "AppDelegate.h"
#import "Macros.h"
#import "Helper.h"
#import <AFViewShaker.h>
#import <KVNProgress.h>

@interface MoreInfoViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;
@property (weak, nonatomic) IBOutlet UITextField *bloodTypeTextField;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (strong, nonatomic) NSArray *bloodTypes;

@end

@implementation MoreInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bloodTypes = @[@[@"A", @"B", @"AB", @"O"],
                        @[@"+", @"-"]];
    
    self.signupButton.layer.cornerRadius = 5.0;
    self.errorLabel.hidden = YES;
    
    /*
     *  Datepicker for birthday
     */
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.maximumDate = [NSDate date];
    datePicker.minuteInterval = 5;
    datePicker.backgroundColor = [UIColor whiteColor];
    [datePicker addTarget:self action:@selector(dateUpdated:) forControlEvents:UIControlEventValueChanged];
    self.birthdayTextField.inputView = datePicker;
    
    /*
     *  Picker for bloodtype
     */
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    picker.dataSource = self;
    picker.delegate = self;
    picker.backgroundColor = [UIColor whiteColor];
    self.bloodTypeTextField.inputView = picker;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [KVNProgress dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Methods
- (IBAction)doSignup:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.birthdayTextField.text.length == 0 ||
        self.bloodTypeTextField.text.length == 0) {
        self.errorLabel.text = @"Preencha todos os campos";
        [self showError];
        return;
    }
    
    [KVNProgress show];
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", self.name, self.surname];
    // is email login
    if (self.password) {
        [[APIService sharedInstance] registerUser:fullName
                                            email:self.email
                                         password:self.password
                                        bloodType:self.bloodTypeTextField.text
                                         birthday:self.birthdayTextField.text
                                            block:^(NSError *error) {
                                                [KVNProgress dismiss];
                                                
                                                if (error) {
                                                    self.errorLabel.text = @"Erro ao registrar Usuário";
                                                    [self showError];
                                                }
                                                else {
                                                    [UIAppDelegate defineRootViewControllerAnimated:YES];
                                                }
                                            }];
    }
    // is facebook login
    else {
        [[APIService sharedInstance] saveFacebookUser:self.name
                                              surname:self.surname
                                                email:self.email
                                             birthday:[Helper parseDateFromString:self.birthdayTextField.text]
                                            bloodType:self.bloodTypeTextField.text
                                            thumbnail:self.thumb
                                                block:^(NSError *error) {
                                                    [KVNProgress dismiss];
                                                    
                                                    if (error) {
                                                        self.errorLabel.text = @"Erro ao fazer login";
                                                        [self showError];
                                                    }
                                                    else {
                                                        [UIAppDelegate defineRootViewControllerAnimated:YES];
                                                    }
                                                }];
    }
}

#pragma mark - Helper Methods
- (void)showError {
    AFViewShaker *shaker = [[AFViewShaker alloc] initWithViewsArray:@[self.birthdayTextField,
                                                                      self.bloodTypeTextField]];
    [shaker shake];
    
    [UIView transitionWithView:self.errorLabel
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.errorLabel.hidden = NO;
                    }
                    completion:NULL];
}

- (void)dateUpdated:(UIDatePicker *)datePicker {
    self.birthdayTextField.text = [Helper formatDate:datePicker.date];
}

#pragma mark - Picker View Data Source
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *array = self.bloodTypes[component];
    return array.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

#pragma mark - Picker View Delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.bloodTypes[component][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *type;
    NSString *rh;
    if (component == 0) {
        type = self.bloodTypes[0][row];
        rh = self.bloodTypes[1][[pickerView selectedRowInComponent:1]];
    }
    else {
        type = self.bloodTypes[0][[pickerView selectedRowInComponent:0]];
        rh = self.bloodTypes[1][row];
    }
    
    self.bloodTypeTextField.text = [NSString stringWithFormat:@"%@%@", type, rh];
}

@end
