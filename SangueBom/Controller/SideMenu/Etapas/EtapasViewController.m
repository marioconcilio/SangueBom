//
//  EtapasViewController.m
//  SangueBom
//
//  Created by Mario Concilio on 10/23/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "EtapasViewController.h"
#import "EtapasCell.h"
#import "UIFont+CustomFont.h"
#import "UIColor+CustomColor.h"
#import "UIViewController+BaseViewController.h"

@interface EtapasViewController ()

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSArray *keys;

@end

static NSString *const CellID = @"Cell";

@implementation EtapasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addDrawerButton];
    
    self.tableView.estimatedRowHeight = 38.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.view.backgroundColor = UIColorFromHEX(0xefeff4);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"etapas" ofType:@"plist"];
    self.data = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.keys = [[self.data allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EtapasCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    NSString *key = self.keys[indexPath.section];
    cell.descriptionLabel.text = self.data[key];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.keys[section];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [UIFont customMediumFontWithSize:15.0];
}

@end
