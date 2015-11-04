//
//  DoeSangueViewController.m
//  SangueBom
//
//  Created by Mario Concilio on 10/23/15.
//  Copyright © 2015 Mario Concilio. All rights reserved.
//

#import "DoeSangueViewController.h"
#import "Helper.h"
#import "DoeSangueCell.h"
#import "DoeSangueButtonCell.h"
#import "UIViewController+BaseViewController.h"
#import "UIColor+CustomColor.h"
#import "UIFont+CustomFont.h"
#import "APIService.h"
#import <BEMCheckBox.h>

@interface DoeSangueViewController () <BEMCheckBoxDelegate>

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSMutableArray *answers;

@end

static NSString *const CellID       = @"Cell";
static NSString *const ButtonCellID = @"ButtonCell";

@implementation DoeSangueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addDrawerButton];
    
//    [[APIService sharedInstance] truncateAllBloodCenters:NULL];
//    [[APIService sharedInstance] populateBloodCenters:NULL];
    
    self.tableView.estimatedRowHeight = 38.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"doe_sangue" ofType:@"plist"];
    self.data = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    self.answers = [Helper createAnswersArrayWithCapacity:self.data.count];
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
    if ([Helper compareAnswers:self.data.allValues with:self.answers]) {
        
    }
    else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ops..."
                                                                                 message:@"Infelizmente você não está apto a doar sangue."
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                         style:UIAlertActionStyleCancel
                                                       handler:NULL];
        
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:NULL];
    }
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
        
        cell.checkBox.on = [self.answers[indexPath.row] boolValue];
        cell.checkBox.tag = indexPath.row;
        cell.checkBox.delegate = self;
        [cell.checkBox reload];
        
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

#pragma mark - BEMCheckBox Delegate
- (void)animationDidStopForCheckBox:(BEMCheckBox *)checkBox {
    self.answers[checkBox.tag] = @(checkBox.on);
}

@end
