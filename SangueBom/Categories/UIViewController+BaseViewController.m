//
//  UIViewController+BaseViewController.m
//  SangueBom
//
//  Created by Mario Concilio on 10/22/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "UIViewController+BaseViewController.h"

@implementation UIViewController (BaseViewController)

- (void)addDrawerButton {
    self.revealViewController.delegate = self;
    
//    CGRect frame = (CGRect) {
//        .size = kVBFButtonSize,
//    };
//    VBFPopFlatButton *button = [[VBFPopFlatButton alloc]initWithFrame:frame
//                                                           buttonType:buttonDefaultType
//                                                          buttonStyle:buttonPlainStyle
//                                                animateToInitialState:YES];
//    button.lineThickness = 1.0;
//    button.tintColor = [UIColor whiteColor];
//    self.drawerButton = button;
//    [button addTarget:self action:@selector(toggleDrawer) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"sgb_menu"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(toggleDrawer)];
}

- (void)toggleDrawer {
    [self.view endEditing:YES];
    [self.revealViewController revealToggleAnimated:YES];
}

#pragma mark - SWRevealViewController Delegate
- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position {
    if ([self.view viewWithTag:1989]) {
        [[self.view viewWithTag:1989] removeFromSuperview];
    }
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position {
    // opened menu
    if (position == FrontViewPositionRight || position == FrontViewPositionLeftSide) {
        UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
        view.backgroundColor = [UIColor clearColor];
        [view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        view.tag = 1989;
        [self.view addSubview:view];
    }
}

@end
