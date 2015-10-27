//
//  UIViewController+BaseViewController.h
//  SangueBom
//
//  Created by Mario Concilio on 10/22/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SWRevealViewController.h>

@interface UIViewController (BaseViewController) <SWRevealViewControllerDelegate>

- (void)addDrawerButton;
- (void)toggleDrawer;

@end
