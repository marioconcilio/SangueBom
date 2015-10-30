//
//  DoeSangueCell.h
//  SangueBom
//
//  Created by Mario Concilio on 10/26/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BEMCheckBox;
@interface DoeSangueCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet BEMCheckBox *checkBox;

@end
