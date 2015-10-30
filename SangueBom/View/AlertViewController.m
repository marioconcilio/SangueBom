//
//  AlertViewController.m
//  SangueBom
//
//  Created by Mario Concilio on 10/28/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "AlertViewController.h"
#import "UIColor+CustomColor.h"
#import "UIFont+CustomFont.h"

@interface AlertViewController ()

@end

@implementation AlertViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundTapDismissalGestureEnabled = YES;
        self.buttonCornerRadius = 5.0;
//        self.view.tintColor = [UIColor customDarkBackground];
        self.titleFont = [UIFont customBoldFontWithSize:17.0];
        self.messageFont = [UIFont customLightFontWithSize:17.0];
        self.buttonTitleFont = [UIFont customLightFontWithSize:17.0];
        self.cancelButtonTitleFont = [UIFont customLightFontWithSize:17.0];
        self.destructiveButtonTitleFont = [UIFont customRegularFontWithSize:17.0];
        self.buttonColor = [UIColor customPurple];
        self.destructiveButtonColor = [UIColor customRed];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
