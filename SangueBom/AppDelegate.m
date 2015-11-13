//
//  AppDelegate.m
//  SangueBom
//
//  Created by Mario Concilio on 9/15/15.
//  Copyright (c) 2015 Mario Concilio. All rights reserved.
//

#import "AppDelegate.h"
#import "UIFont+CustomFont.h"
#import "UIColor+CustomColor.h"
#import "UIStoryboard+CustomStoryboard.h"
#import "Macros.h"
#import "Constants.h"
#import <TestFairy.h>
#import <KVNProgress/KVNProgress.h>
#import <KVNProgress/KVNProgressConfiguration.h>
#import <MagicalRecord/MagicalRecord.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [TestFairy begin:@"939e8063f824164d535ee589a9000b7765bd5ed2"];
    
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont customThinFontWithSize:18.0],
                                                           NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor customRed]];
//    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    KVNProgressConfiguration *config = [[KVNProgressConfiguration alloc] init];
    config.statusFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:15.0];
    [KVNProgress setConfiguration:config];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    [MagicalRecord setupCoreDataStack];
    [self defineRootViewControllerAnimated:YES];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation
            ];
}

- (void)defineRootViewControllerAnimated:(BOOL)animated {
    UIViewController *vc = nil;
    if ([NSUserDefaults objectForKey:kUserToken]) {
        vc = [[UIStoryboard mainStoryboard] instantiateInitialViewController];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    }
    else {
        vc = [[UIStoryboard welcomeStoryboard] instantiateInitialViewController];
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    if (animated) {
        [UIView transitionWithView:self.window
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            self.window.rootViewController = vc;
                        }
                        completion:NULL];
    }
    else {
        self.window.rootViewController = vc;
    }
}

@end
