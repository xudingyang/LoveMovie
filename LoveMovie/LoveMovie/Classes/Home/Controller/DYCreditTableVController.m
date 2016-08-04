//
//  DYCreditTableVController.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/26.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYCreditTableVController.h"
#import "DYCreditsTableViewCell.h"
#import "DYPerson.h"
#import "DYPosition.h"

@interface DYCreditTableVController ()

@end

static NSString * const identifier = @"DYCreditsTableViewCell";

@implementation DYCreditTableVController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

#pragma mark - 设置tableView
- (void)setupTableView{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DYCreditsTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    self.tableView.rowHeight = 110;
    self.navigationItem.title = @"演职员";
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.position.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DYPosition *position = self.position[section];
    return position.persons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYCreditsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    DYPosition *position = self.position[indexPath.section];
    DYPerson *person = position.persons[indexPath.row];
    person.personType = position.typeName;
    cell.person = person;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    DYPosition *position = self.position[section];
    return [NSString stringWithFormat:@"%@ %@", position.typeName, position.typeNameEn];
}

@end
