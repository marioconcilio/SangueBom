//
//  DoeSangueCell.m
//  SangueBom
//
//  Created by Mario Concilio on 10/26/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "DoeSangueCell.h"
#import "UIColor+CustomColor.h"
#import <BEMCheckBox.h>

@interface DoeSangueCell ()

@end

@implementation DoeSangueCell

- (void)awakeFromNib {
    self.containerView.backgroundColor = [UIColor whiteColor];
    self.containerView.layer.cornerRadius = 20.0;
    self.containerView.layer.borderColor = [UIColor customLightGray].CGColor;
    self.containerView.layer.borderWidth = 1.0;
    
    self.checkBox.onAnimationType = BEMAnimationTypeFill;
    self.checkBox.offAnimationType = BEMAnimationTypeFill;
    self.checkBox.tintColor = [UIColor customLightGray];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
