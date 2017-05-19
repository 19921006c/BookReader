//
//  ReadBookViewController.m
//  JoeBookPhone
//
//  Created by joe on 2017/5/17.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "ReadBookViewController.h"
#import "BRPageViewController.h"
#import "ReadBookOperationView.h"
@interface ReadBookViewController ()<UIGestureRecognizerDelegate>

/** 每一页controller */
@property (nonatomic, strong) BRPageViewController *pageViewController;
@property (nonatomic, strong) ReadBookOperationView *operationView;
@end

@implementation ReadBookViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.view addSubview:self.operationView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleClickEvent)];
    [self.view addGestureRecognizer:tap];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.pageViewController.view.frame = self.view.bounds;
    self.operationView.frame = self.view.bounds;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (BOOL)prefersStatusBarHidden
{
    return self.operationView.hidden;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark - delegate

#pragma mark - event response
- (void)close {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - private methods
- (void)singleClickEvent
{
    [self.operationView didClick];
}
#pragma mark - getters and setters
- (BRPageViewController *)pageViewController
{
    if (!_pageViewController) {
        NSDictionary *options = @{UIPageViewControllerOptionInterPageSpacingKey : @(1)};
        _pageViewController = [[BRPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    }
    return _pageViewController;
}
- (void)setModel:(BRBookModel *)model
{
    _model = model;
    
    self.pageViewController.model = model;
}
- (ReadBookOperationView *)operationView
{
    if (!_operationView) {
        _operationView = [ReadBookOperationView operationView];
    }
    return _operationView;
}
@end
