//
//  ReadBookViewController.m
//  JoeBookPhone
//
//  Created by joe on 2017/5/17.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "ReadBookViewController.h"
#import "ContentViewController.h"

@interface ReadBookViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

/** 每一页controller */
@property (nonatomic, strong) UIPageViewController *pageViewController;
/** 数据源 */
//@property (nonatomic, strong) NSArray *pageArray;
/** 临时btn */
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation ReadBookViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //拿到第一页
    ContentViewController *vc = [self viewControllerWithIndex:0];
    NSArray *vcs = [NSArray arrayWithObject:vc];
    [self.pageViewController setViewControllers:vcs direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    self.pageViewController.view.frame = self.view.bounds;
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.view addSubview:self.closeButton];
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
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
#pragma mark - delegate
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexWithViewController:(ContentViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    // 返回的ViewController，将被添加到相应的UIPageViewController对象上。
    // UIPageViewController对象会根据UIPageViewControllerDataSource协议方法,自动来维护次序
    // 不用我们去操心每个ViewController的顺序问题
    return [self viewControllerWithIndex:index];
}

/** 拿到下一个controller */
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexWithViewController:(ContentViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.model.pageModelArray count]) {
        return nil;
    }
    return [self viewControllerWithIndex:index];
    
    
}
#pragma mark - event response
- (void)close {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - private methods
/** 通过下标获取controller */
- (ContentViewController *)viewControllerWithIndex:(NSUInteger)index {
    if (self.model.pageModelArray.count == 0 || (index > self.model.pageModelArray.count)) {
        return nil;
    }
    ContentViewController *vc = [[ContentViewController alloc] init];
    vc.model = self.model.pageModelArray[index];
    return vc;
}
#pragma mark - 通过controller获取下标
- (NSUInteger)indexWithViewController:(ContentViewController *)viewController {
    return [self.model.pageModelArray indexOfObject:viewController.model];
}
#pragma mark - getters and setters
- (UIPageViewController *)pageViewController
{
    if (!_pageViewController) {
        NSDictionary *options = @{UIPageViewControllerOptionInterPageSpacingKey : @(1)};
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
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
@end
