//
//  DBCameraLoadingView.m
//  DBCamera
//
//  Created by Marco De Nadai on 23/06/14.
//  Copyright (c) 2014 PSSD - Daniele Bogo. All rights reserved.
//

#import "DBCameraLoadingView.h"
#import "DBCameraMacros.h"

//#import <Fanta-Swift.h>
//#import <BLMultiColorLoader.h>
//#import <KVNProgress.h>

@implementation DBCameraLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self.layer setCornerRadius:10];
//        [self setBackgroundColor:RGBColor(0x000000, .7)];
        self.backgroundColor = [UIColor clearColor];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = frame;
        blurEffectView.layer.cornerRadius = 10.0;
        blurEffectView.layer.masksToBounds = YES;
        [self addSubview:blurEffectView];
            
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [activity setCenter:(CGPoint){ CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) }];
        [self addSubview:activity];
        [activity startAnimating];
        
//        BLMultiColorLoader *indicator = [[BLMultiColorLoader alloc] init];
//        indicator.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame)*0.5, CGRectGetHeight(self.frame)*0.5);
//        indicator.center = self.center;
//        indicator.lineWidth = 1.0;
//        indicator.colorArray = @[[UIColor customPink],
//                                 [UIColor customYellow],
//                                 [UIColor customOrange]];
//        [self addSubview:indicator];
//        [indicator startAnimation];
        
//        SpringIndicator *indicator = [[SpringIndicator alloc] init];
//        indicator.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame)*0.5, CGRectGetHeight(self.frame)*0.5);
//        indicator.center = self.center;
//        indicator.lineWidth = 1.0;
//        indicator.lineColor = [UIColor whiteColor];
//        [self addSubview:indicator];
//        [indicator startAnimation:YES];
//        [indicator startAnimationWithExpand:NO];
    }
    
    return self;
}


@end
