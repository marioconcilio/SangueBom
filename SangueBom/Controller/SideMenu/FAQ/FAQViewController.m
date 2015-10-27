//
//  FAQViewController.m
//  SangueBom
//
//  Created by Mario Concilio on 10/26/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "FAQViewController.h"
#import "FAQCell.h"
#import "Macros.h"
#import "UIViewController+BaseViewController.h"
#import "UIFont+CustomFont.h"

@interface FAQViewController ()

@property (nonatomic, strong) NSDictionary *data;

@end

static NSString *const CellID = @"Cell";

@implementation FAQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addDrawerButton];
    
    self.tableView.estimatedRowHeight = 38.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionHeaderHeight = 22.0;
    self.view.backgroundColor = UIColorFromHEX(0xefeff4);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"faq" ofType:@"plist"];
    self.data = [[NSDictionary alloc] initWithContentsOfFile:path];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table View Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.data allKeys].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FAQCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    NSString *key = [self.data allKeys][indexPath.section];
    cell.descriptionLabel.text = self.data[key];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.data allKeys][section];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return [[self.heightCache objectForKey:@(section)] floatValue];
//}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [UIFont customMediumFontWithSize:15.0];
    header.textLabel.numberOfLines = 0;
}

@end
