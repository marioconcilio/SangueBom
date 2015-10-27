//
//  DoeSangueButtonCell.m
//  SangueBom
//
//  Created by Mario Concilio on 10/26/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "DoeSangueButtonCell.h"

@interface DoeSangueButtonCell ()

@end

@implementation DoeSangueButtonCell

- (void)awakeFromNib {
    self.button.layer.cornerRadius = 5.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
