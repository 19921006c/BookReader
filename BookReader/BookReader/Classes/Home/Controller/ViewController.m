//
//  ViewController.m
//  JoeBookPhone
//
//  Created by joe on 2017/5/17.
//  Copyright © 2017年 joe. All rights reserved.
//

/** 书籍上传完毕通知key */
#define kUploadFinishNTKey @"kUploadFinishNTKey"

#import "ViewController.h"
#import "ReadBookViewController.h"
#import "BRBookModel.h"
#import "HTTPServer.h"
#import "MyHTTPConnection.h"
#import "BRIPHelper.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>{
    HTTPServer *httpServer;
}
/** 书籍目录tableView */
@property (nonatomic, strong) UITableView *tableView;

/** 数据源数组 */
@property (nonatomic, strong) NSArray *dataSourceArray;
@end

@implementation ViewController

/** 复用identifier */
static NSString *const identifier = @"HomeTableViewCellIdentifier";
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 将tableview 加入self.view */
    [self.view addSubview:self.tableView];
    /** 设置navigation left bar button item */
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightDown)];
    
    /** 接受书籍上传完毕通知 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadFinish) name:kUploadFinishNTKey object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /** 设置tableView frame */
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
    BRBookModel *model = [BRReadBookTool getModelWithFileName:self.dataSourceArray[indexPath.row]];
    /** model为空则return掉 */
    if (!model) return;
    ReadBookViewController *vc = [[ReadBookViewController alloc] init];
    vc.model = model;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - event response

/**
 点击navigation bar 右侧 item 事件响应
 */
- (void)rightDown
{
    /** 创建服务器 */
    NSString * webLocalPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"web"];
//    NSString *webLocalPath = [[NSBundle mainBundle] resourcePath];
    
    httpServer = [[HTTPServer alloc] init];
    [httpServer setType:@"_http._tcp."];
    // webPath是server搜寻HTML等文件的路径
    [httpServer setDocumentRoot:webLocalPath];
    [httpServer setConnectionClass:[MyHTTPConnection class]];
    NSError *err;
    if ([httpServer start:&err]) {
        NSLog(@"port %hu",[httpServer listeningPort]);
    }else{
        NSLog(@"%@",err);
    }
    
    NSString *ip = [BRIPHelper deviceIPAdress];
    NSLog(@"ipipip = %@", ip);
    NSString *address = [NSString stringWithFormat:@"%@:%hu", [BRIPHelper deviceIPAdress], [httpServer listeningPort]];
    
    /** 创建alert controller */
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"wifi传书" message:[NSString stringWithFormat:@"在电脑浏览器输入地址:\n%@", address] preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [httpServer stop];
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [httpServer stop];
    }];
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - private methods

/**
 接受到书籍上传完成后，调用方法
 */
- (void)uploadFinish
{
    //1. 给数据源赋值
    self.dataSourceArray = [BRReadBookTool getTotalBookList];
    //2. 刷新tableView
    [self.tableView reloadData];
}
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
        _dataSourceArray = [BRReadBookTool getTotalBookList];
    }
    return _dataSourceArray;
}

@end
