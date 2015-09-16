//
//  WelcomeTests.m
//  SangueBom
//
//  Created by Mario Concilio on 9/16/15.
//  Copyright (c) 2015 Mario Concilio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <KIF/KIF.h>

@interface WelcomeTests : KIFTestCase

@end

@implementation WelcomeTests

- (void)test00Signup {
    // navigate to signup
    [tester tapViewWithAccessibilityLabel:@"Criar Conta"];
    [tester waitForViewWithAccessibilityLabel:@"Criar Conta"];
    
    [tester enterText:@"Marcos" intoViewWithAccessibilityLabel:@"Nome"];
    [tester tapViewWithAccessibilityLabel:@"return"];
    XCTAssertTrue([[tester waitForViewWithAccessibilityLabel:@"Sobrenome"] isFirstResponder],
                  @"surname textfield is NOT responding after name");
    
    [tester enterText:@"Chain" intoViewWithAccessibilityLabel:@"Sobrenome"];
    [tester tapViewWithAccessibilityLabel:@"return"];
    XCTAssertTrue([[tester waitForViewWithAccessibilityLabel:@"Email"] isFirstResponder],
                  @"email textfield is NOT responding after surname");
    
    [tester enterText:@"marcos.chain@usp.br" intoViewWithAccessibilityLabel:@"Email"];
    [tester tapViewWithAccessibilityLabel:@"return"];
    XCTAssertTrue([[tester waitForViewWithAccessibilityLabel:@"Senha"] isFirstResponder],
                  @"password textfield is NOT responding after email");
    
    // back to welcome
    [tester tapViewWithAccessibilityLabel:@"Back"];
    [tester waitForViewWithAccessibilityLabel:@"SangueBOM"];
}

- (void)test01SignupTextFields {
    
}

- (void)test02NavigationToLogin {
    // navigate to login
    [tester tapViewWithAccessibilityLabel:@"Já Possuo Conta"];
    [tester waitForViewWithAccessibilityLabel:@"Login"];
    
    // back to welcome
    [tester tapViewWithAccessibilityLabel:@"Back"];
    [tester waitForViewWithAccessibilityLabel:@"SangueBOM"];
}

@end
