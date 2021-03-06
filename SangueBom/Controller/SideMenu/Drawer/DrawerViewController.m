//
//  DrawerViewController.m
//  SangueBom
//
//  Created by Mario Concilio on 10/22/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "UIColor+CustomColor.h"
#import "UIStoryboard+CustomStoryboard.h"
#import "UIFont+CustomFont.h"
#import "DrawerViewController.h"
#import "Helper.h"
#import "VOUser.h"
#import "Constants.h"
#import <SWRevealViewController.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface DrawerViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation DrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.revealViewController.toggleAnimationType = SWRevealToggleAnimationTypeEaseOut;
    self.revealViewController.rightViewRevealOverdraw = 0.0;
    self.revealViewController.rearViewRevealOverdraw = 0.0;
    self.revealViewController.rearViewRevealWidth = -55.0;
    self.revealViewController.rightViewRevealWidth = -55.0;
    
    self.profileImageView.layer.cornerRadius = 50.0;
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.borderColor = [UIColor customDarkBackground].CGColor;
    self.profileImageView.layer.borderWidth = 1.0;
    self.profileImageView.accessibilityLabel = kProfileImageViewLabel;
    
    self.tableView.separatorColor = [UIColor customDarkBackground];
    self.tableView.accessibilityLabel = kDrawerTableLabel;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    Person *person = [Helper loadUser];
    VOUser *user = [Helper loadUser];
    self.nameLabel.text = [NSString stringWithFormat:@"%@", user.name];
    
    [Helper avatarFromName:self.nameLabel.text font:[UIFont customUltraLightFontWithSize:30.0] diameter:100.0 callback:^(UIImage *image) {
        
//        if (person.thumbnail) {
//            NSURL *url;
//            if ([person.thumbnail hasPrefix:@"http"]) {
//                url = [NSURL URLWithString:person.thumbnail];
//            }
//            else {
//                url = [NSURL fileURLWithPath:[person.thumbnail stringByExpandingTildeInPath]];
//            }
//            
//            [self.profileImageView setImageWithURL:url placeholderImage:image];
//        }
//        else {
            self.profileImageView.image = image;
//        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Datasource
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor customRed];
        cell.selectedBackgroundView = view;
    }
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc = nil;
    switch (indexPath.row) {
        case 0:
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"perfil"];
            break;
            
        case 1:
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"doe_sangue"];
            break;
            
        case 2:
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"etapas"];
            break;
            
        case 3:
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"curiosidades"];
            break;
            
        case 4:
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"faq"];
            break;
            
        case 5:
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"map"];
            break;
            
        default:
            NSLog(@"not implemented yet");
            break;
    }
    
    if (!vc) {
        vc = self.revealViewController.frontViewController;
    }
    
    [self.revealViewController pushFrontViewController:vc animated:YES];
}

@end
