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

@interface WelcomeUITests : KIFTestCase

@end

@implementation WelcomeUITests

- (void)test00NavigationToSignup {
    [tester tapViewWithAccessibilityLabel:@"Criar Conta"];
    [tester waitForViewWithAccessibilityLabel:@"Criar Conta"];
}

- (void)test01SignupTextFields {
    // test error label
    [tester tapViewWithAccessibilityLabel:@"Criar"];
    [tester waitForViewWithAccessibilityLabel:@"errorLabel"];
    
    // test sequence of textfields
    [tester enterText:@"m" intoViewWithAccessibilityLabel:@"Nome"];
    [tester tapViewWithAccessibilityLabel:@"return"];
    XCTAssertTrue([[tester waitForViewWithAccessibilityLabel:@"Sobrenome"] isFirstResponder],
                  @"surname textfield IS NOT first responder after name");
    
    [tester enterText:@"m" intoViewWithAccessibilityLabel:@"Sobrenome"];
    [tester tapViewWithAccessibilityLabel:@"return"];
    XCTAssertTrue([[tester waitForViewWithAccessibilityLabel:@"Email"] isFirstResponder],
                  @"email textfield IS NOT first responder after surname");
    
    [tester enterText:@"m" intoViewWithAccessibilityLabel:@"Email"];
    [tester tapViewWithAccessibilityLabel:@"return"];
    XCTAssertTrue([[tester waitForViewWithAccessibilityLabel:@"Senha"] isFirstResponder],
                  @"password textfield IS NOT first responder after email");
}

- (void)test02BackToWelcome {
    [self backToWelcome];
}

- (void)test03NavigationToLogin {
    // navigate to login
    [tester tapViewWithAccessibilityLabel:@"Já Possuo Conta"];
    [tester waitForViewWithAccessibilityLabel:@"Login"];
}

- (void)test04LoginTextFields {
    // test error label
    [tester tapViewWithAccessibilityLabel:@"Entrar"];
    [tester waitForViewWithAccessibilityLabel:@"errorLabel"];
    
    // test sequence of textfields
    [tester enterText:@"m" intoViewWithAccessibilityLabel:@"Email"];
    [tester tapViewWithAccessibilityLabel:@"return"];
    XCTAssertTrue([[tester waitForViewWithAccessibilityLabel:@"Senha"] isFirstResponder],
                  @"password IS NOT first responder after email");
    
    [tester enterText:@"m" intoViewWithAccessibilityLabel:@"Senha"];
    [tester tapViewWithAccessibilityLabel:@"Entrar"];
}

- (void)test05BackToWelcome {
    [self backToWelcome];
}

#pragma mark - Helper Methods
- (void)backToWelcome {
    [tester tapViewWithAccessibilityLabel:@"Back"];
    [tester waitForViewWithAccessibilityLabel:@"SangueBOM"];
}

@end
