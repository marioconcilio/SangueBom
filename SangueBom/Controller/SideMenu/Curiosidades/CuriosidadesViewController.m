//
//  CuriosidadesViewController.m
//  SangueBom
//
//  Created by Mario Concilio on 10/23/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "CuriosidadesViewController.h"
#import "CuriosidadesCell.h"
#import "UIFont+CustomFont.h"
#import "UIViewController+BaseViewController.h"
#import "Macros.h"

@interface CuriosidadesViewController ()

@property (nonatomic, strong) NSArray<NSString *> *data;

@end

static NSString *const CellID = @"Cell";

@implementation CuriosidadesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addDrawerButton];
    
    self.tableView.estimatedRowHeight = 38.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"curiosidades" ofType:@"plist"];
    self.data = [[NSArray alloc] initWithContentsOfFile:path];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CuriosidadesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.descriptionLabel.text = self.data[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%ld.", (long)section+1];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [UIFont customMediumFontWithSize:15.0];
}
 */

@end
