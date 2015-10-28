//
//  DoeSangueViewController.m
//  SangueBom
//
//  Created by Mario Concilio on 10/23/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "DoeSangueViewController.h"
#import "DoeSangueCell.h"
#import "DoeSangueButtonCell.h"
#import "UIViewController+BaseViewController.h"
#import "UIColor+CustomColor.h"
#import "UIFont+CustomFont.h"

@interface DoeSangueViewController ()

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSMutableDictionary *answers;

@end

static NSString *const CellID       = @"Cell";
static NSString *const ButtonCellID = @"ButtonCell";

@implementation DoeSangueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addDrawerButton];
    
    self.tableView.estimatedRowHeight = 38.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.view.backgroundColor = UIColorFromHEX(0xefeff4);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"doe_sangue" ofType:@"plist"];
    self.data = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    self.answers = [self.data mutableCopy];
    NSArray *allValues = [self.answers allValues];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (void)doVerify {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

#pragma mark - Table View Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.data.count;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return UITableViewAutomaticDimension;
    }
    
    return 61.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        DoeSangueCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
        cell.descriptionLabel.text = [self.data allKeys][indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    DoeSangueButtonCell *buttonCell = [tableView dequeueReusableCellWithIdentifier:ButtonCellID forIndexPath:indexPath];
    [buttonCell.button addTarget:self action:@selector(doVerify) forControlEvents:UIControlEventTouchUpInside];
    
    return buttonCell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Você pode doar sangue?";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return UITableViewAutomaticDimension;
    }
    
    return 0.0;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [UIFont customMediumFontWithSize:15.0];
}

@end
