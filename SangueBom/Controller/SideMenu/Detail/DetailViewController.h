//
//  DetailViewController.h
//  SangueBom
//
//  Created by Mario Concilio on 11/4/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VOBloodCenter;
@interface DetailViewController : UITableViewController

@property (nonnull, nonatomic, strong) VOBloodCenter *bloodCenter;

@end
