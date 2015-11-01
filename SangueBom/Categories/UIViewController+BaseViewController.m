//
//  UIViewController+BaseViewController.m
//  SangueBom
//
//  Created by Mario Concilio on 10/22/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "Constants.h"
#import "UIViewController+BaseViewController.h"

#define kViewTag    1989

@implementation UIViewController (BaseViewController)

- (void)addDrawerButton {
    self.revealViewController.delegate = self;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"sgb_menu"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(toggleDrawer)];
    
    self.navigationItem.leftBarButtonItem.accessibilityLabel = kDrawerButtonLabel;
}

- (void)toggleDrawer {
    [self.view endEditing:YES];
    [self.revealViewController revealToggleAnimated:YES];
}

#pragma mark - SWRevealViewController Delegate
- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position {
    if ([self.view viewWithTag:kViewTag]) {
        [[self.view viewWithTag:kViewTag] removeFromSuperview];
    }
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position {
    // opened menu
    if (position == FrontViewPositionRight || position == FrontViewPositionLeftSide) {
        UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
        view.backgroundColor = [UIColor clearColor];
        [view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        view.tag = kViewTag;
        [self.view addSubview:view];
    }
}

@end
