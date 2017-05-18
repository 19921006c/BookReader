//
//  ViewController.m
//  JoeBookPhone
//
//  Created by joe on 2017/5/17.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "ViewController.h"
#import "ReadBookViewController.h"
#import "BRBookModel.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSourceArray;
@end

@implementation ViewController

static NSString *const identifier = @"HomeTableViewCellIdentifier";
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tableView.frame = self.view.bounds;
}
#pragma mark - delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.detailTextLabel.text = self.dataSourceArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BRBookModel *model = [[BRBookModel alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"花间提壶方大厨.txt" ofType:nil];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:0x80000632 error:nil];
    model.content = content;
    ReadBookViewController *vc = [[ReadBookViewController alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - event response
#pragma mark - private methods
#pragma mark - getters and setters
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSArray *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray = [NSArray arrayWithObject:@"花间提壶方大厨.txt"];
    }
    return _dataSourceArray;
}

@end
