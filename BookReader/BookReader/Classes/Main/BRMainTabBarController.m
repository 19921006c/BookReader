//
//  BRMainTabBarController.m
//  BookReader
//
//  Created by joe on 2017/5/18.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "BRMainTabBarController.h"
#import "BRMainNavigationController.h"
#import "ViewController.h"
@interface BRMainTabBarController ()

/**
 首页控制器
 */
@property (nonatomic, strong) ViewController *homeVc;
@end

@implementation BRMainTabBarController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTotalChildController];
}
#pragma mark - delegate
/**
 *  添加所有的ViewController
 */
- (void)addTotalChildController {
    [self addAloneChildController:self.homeVc title:@"首页"];
}
/**
 添加单个控制器
 
 @param controller 压入栈种的控制器
 @param title navigationBarTitle and tabBarItemTitle
 */
- (void)addAloneChildController:(UIViewController *)controller title:(NSString *)title{
    /** 设置controller title */
    controller.title = title;
    /** 创建NavigationController 并设置其rooterViewController */
    BRMainNavigationController *ngVc = [[BRMainNavigationController alloc] initWithRootViewController:controller];
    /** 将navigationController加入到tabBarController中 */
    [self addChildViewController:ngVc];
}
#pragma mark - event response
#pragma mark - private methods
#pragma mark - getters and setters
- (ViewController *)homeVc {
    if (!_homeVc) {
        _homeVc = [[ViewController alloc] init];
    }
    return _homeVc;
}
@end
