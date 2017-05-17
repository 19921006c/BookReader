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

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSArray *pageArray;

@end

@implementation ReadBookViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    //拿到第一页
    ContentViewController *vc = [self viewControllerWithIndex:0];
    NSArray *vcs = [NSArray arrayWithObject:vc];
    [self.pageViewController setViewControllers:vcs direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    self.pageViewController.view.frame = self.view.bounds;
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}
#pragma mark - delegate
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(ContentViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    // 返回的ViewController，将被添加到相应的UIPageViewController对象上。
    // UIPageViewController对象会根据UIPageViewControllerDataSource协议方法,自动来维护次序
    // 不用我们去操心每个ViewController的顺序问题
    return [self viewControllerWithIndex:index];
}

#pragma mark 返回下一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(ContentViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.pageArray count]) {
        return nil;
    }
    return [self viewControllerWithIndex:index];
    
    
}
#pragma mark - event response
#pragma mark - private methods
- (ContentViewController *)viewControllerWithIndex:(NSUInteger)index {
    if (self.pageArray.count == 0 || (index > self.pageArray.count)) {
        return nil;
    }
    ContentViewController *vc = [[ContentViewController alloc] init];
    vc.content = self.pageArray[index];
    return vc;
}
#pragma mark - 数组元素值，得到下标值

- (NSUInteger)indexOfViewController:(ContentViewController *)viewController {
    return [self.pageArray indexOfObject:viewController.content];
}
#pragma mark - getters and setters
- (NSArray *)pageArray
{
    if (!_pageArray) {
        NSMutableArray *arrayM = [[NSMutableArray alloc] init];
        for (int i = 1; i < 10; i++) {
            NSString *contentString = [[NSString alloc] initWithFormat:@"This is the page %d of content displayed using UIPageViewController", i];
            [arrayM addObject:contentString];
        }
        _pageArray = [[NSArray alloc] initWithArray:arrayM];
    }
    return _pageArray;
}
- (UIPageViewController *)pageViewController
{
    if (!_pageViewController) {
        NSDictionary *options = @{UIPageViewControllerOptionInterPageSpacingKey : @(20)};
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
    }
    return _pageViewController;
}
@end
