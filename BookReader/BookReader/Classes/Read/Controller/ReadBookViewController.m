//
//  ReadBookViewController.m
//  JoeBookPhone
//
//  Created by joe on 2017/5/17.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "ReadBookViewController.h"
#import "BRPageViewController.h"
@interface ReadBookViewController ()<UIGestureRecognizerDelegate>

/** 每一页controller */
@property (nonatomic, strong) BRPageViewController *pageViewController;
/** 临时btn */
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation ReadBookViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.view addSubview:self.closeButton];
    [self.view addGestureRecognizer:({
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showOperationMenu)];
        tap.delegate = self;
        tap;
    })];
}
- (void)showOperationMenu
{
    
    
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.closeButton.frame = CGRectMake(0, kMainScreenHeight - 50, 50, 50);
    self.pageViewController.view.frame = self.view.bounds;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
#pragma mark - delegate

#pragma mark - event response
- (void)close {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - private methods

#pragma mark - getters and setters
- (BRPageViewController *)pageViewController
{
    if (!_pageViewController) {
        NSDictionary *options = @{UIPageViewControllerOptionInterPageSpacingKey : @(1)};
        _pageViewController = [[BRPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    }
    return _pageViewController;
}
- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setTitle:@"clost" forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton setBackgroundColor:[UIColor blueColor]];
    }
    return _closeButton;
}
- (void)setModel:(BRBookModel *)model
{
    _model = model;
    
    self.pageViewController.model = model;
}
@end
