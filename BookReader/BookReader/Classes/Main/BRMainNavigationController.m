//
//  BRMainNavigationController.m
//  BookReader
//
//  Created by joe on 2017/5/18.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "BRMainNavigationController.h"

@interface BRMainNavigationController ()

@end

@implementation BRMainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //不是栈底控制器时, 隐藏tabbar
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
