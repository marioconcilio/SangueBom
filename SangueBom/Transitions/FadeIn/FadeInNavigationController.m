//
//  NavigationController.m
//  Fanta
//
//  Created by Mario Concilio on 5/29/15.
//  Copyright (c) 2015 Mario Concilio. All rights reserved.
//

#import "FadeInNavigationController.h"
#import "FadeInAnimator.h"

@interface FadeInNavigationController () <UINavigationControllerDelegate>

@end

@implementation FadeInNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation Controller Delegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController*)fromVC
                                                 toViewController:(UIViewController*)toVC {
    if (operation == UINavigationControllerOperationPush)
        return [[FadeInPushAnimator alloc] init];
    
    if (operation == UINavigationControllerOperationPop)
        return [[FadeInPopAnimator alloc] init];
    
    return nil;
}

@end
