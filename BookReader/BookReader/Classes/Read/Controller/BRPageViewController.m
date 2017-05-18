//
//  BRPageViewController.m
//  BookReader
//
//  Created by joe on 2017/5/18.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "BRPageViewController.h"
#import "ContentViewController.h"
#import "BRBookModel.h"
@interface BRPageViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@end

@implementation BRPageViewController
#pragma mark - life cycle
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
-(instancetype)init
{
    if (self = [super init]) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


@end