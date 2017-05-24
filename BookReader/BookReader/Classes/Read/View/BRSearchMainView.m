//
//  BRSearchMainView.m
//  BookReader
//
//  Created by joe on 2017/5/23.
//  Copyright © 2017年 joe. All rights reserved.
//

#define kBRSearchMainViewNFKey @"kBRSearchMainViewNFKey"

#import "BRSearchMainView.h"
#import "BRSearchModel.h"
#import "BRSearchMainViewHeader.h"
#import "BRSearchMainViewCell.h"
@interface BRSearchMainView ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 数据源 */
@property (nonatomic, strong) NSArray *array;
@end
@implementation BRSearchMainView

static NSString *const identifier = @"BRSearchViewCell";
#pragma mark - life cycle
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.textField.delegate = self;
}
#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BRSearchMainViewCell *cell = [BRSearchMainViewCell cellWithTableView:tableView];
    cell.model = self.array[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BRSearchMainViewHeader *header = [BRSearchMainViewHeader header];
    header.array = self.array;
    return header;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BRSearchModel *model = self.array[indexPath.row];
    NSDictionary *dic = @{@"pageNum" : [NSString stringWithFormat:@"%ld", model.index]};
    [[NSNotificationCenter defaultCenter] postNotificationName:kBRSearchMainViewNFKey object:nil userInfo:dic];
    [[BRCommonTool findNearsetViewController:self].navigationController popViewControllerAnimated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.array = [BRReadBookTool searchTargetWithStr:textField.text model:self.model];
    [self.tableView reloadData];
    
    return YES;
}
#pragma mark - event response
- (IBAction)btnClick:(id)sender {
    [[BRCommonTool findNearsetViewController:self].navigationController popViewControllerAnimated:YES];
}
#pragma mark - private methods
#pragma mark - getters and setters


@end
