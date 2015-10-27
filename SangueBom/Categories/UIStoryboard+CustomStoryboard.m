//
//  UIStoryboard+CustomStoryboard.m
//  SangueBom
//
//  Created by Mario Concilio on 10/23/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "UIStoryboard+CustomStoryboard.h"

@implementation MainStoryboard

- (EtapasViewController *)etapasViewController {
    return (EtapasViewController *)[self instantiateViewControllerWithIdentifier:@"etapas"];
}

@end

@implementation UIStoryboard (CustomStoryboard)

+ (MainStoryboard *)mainStoryboard {
    return (MainStoryboard *)[self storyboardWithName:@"Main" bundle:nil];
}

+ (UIStoryboard *)welcomeStoryboard {
    return [self storyboardWithName:@"Welcome" bundle:nil];
}

@end
