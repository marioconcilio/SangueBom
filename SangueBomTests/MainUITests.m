//
//  MainUITests.m
//  SangueBom
//
//  Created by Mario Concilio on 11/1/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "Constants.h"
#import <XCTest/XCTest.h>
#import <KIF/KIF.h>

@interface MainUITests : KIFTestCase

@end

@implementation MainUITests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Test Methods
- (void)test00_openProfile {
    [self openDrawer];
    [tester tapViewWithAccessibilityLabel:@"Perfil"];
    [tester waitForViewWithAccessibilityLabel:@"Perfil"];
}

- (void)test01_doLogout {
    [tester tapViewWithAccessibilityLabel:@"Logout"];
    [tester waitForViewWithAccessibilityLabel:kAlertViewLabel];
    
    [tester tapViewWithAccessibilityLabel:@"Cancelar"];
    [tester waitForViewWithAccessibilityLabel:@"Perfil"];
}

- (void)test02_openDoeSangue {
    [self openDrawer];
    [tester tapViewWithAccessibilityLabel:@"Doe Sangue"];
    [tester waitForViewWithAccessibilityLabel:@"Doe Sangue"];
}

- (void)test03_doVerificar {
    [tester tapViewWithAccessibilityLabel:@"Verificar"];
    [tester waitForViewWithAccessibilityLabel:kAlertViewLabel];
    
    [tester tapViewWithAccessibilityLabel:@"Ok"];
    [tester waitForViewWithAccessibilityLabel:@"Doe Sangue"];
}

- (void)test04_openEtapas {
    [self openDrawer];
    [tester tapViewWithAccessibilityLabel:@"Etapas"];
    [tester waitForViewWithAccessibilityLabel:@"Etapas"];
}

- (void)test05_openCuriosidades {
    [self openDrawer];
    [tester tapViewWithAccessibilityLabel:@"Curiosidades"];
    [tester waitForViewWithAccessibilityLabel:@"Curiosidades"];
}

- (void)test06_openFAQ {
    [self openDrawer];
    [tester tapViewWithAccessibilityLabel:@"Dúvidas Frequentes"];
    [tester waitForViewWithAccessibilityLabel:@"Dúvidas Frequentes"];
}

- (void)test07_openMap {
    [self openDrawer];
    [tester tapViewWithAccessibilityLabel:@"Hemocentros"];
    [tester waitForViewWithAccessibilityLabel:@"Hemocentros"];
}

- (void)test08_openCloseDrawer {
    [self openDrawer];
    [tester tapViewWithAccessibilityLabel:kDrawerButtonLabel];
    [tester waitForViewWithAccessibilityLabel:@"Hemocentros"];
}

#pragma mark - Helper Methods
- (void)openDrawer {
    [tester tapViewWithAccessibilityLabel:kDrawerButtonLabel];
    [tester waitForViewWithAccessibilityLabel:kDrawerTableLabel];
}

@end
