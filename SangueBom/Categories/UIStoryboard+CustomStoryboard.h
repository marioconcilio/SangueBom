//
//  UIStoryboard+CustomStoryboard.h
//  SangueBom
//
//  Created by Mario Concilio on 10/23/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EtapasViewController;
@interface MainStoryboard : UIStoryboard

- (EtapasViewController *)etapasViewController;

@end

@interface UIStoryboard (CustomStoryboard)

+ (MainStoryboard *)mainStoryboard;
+ (UIStoryboard *)welcomeStoryboard;

@end
