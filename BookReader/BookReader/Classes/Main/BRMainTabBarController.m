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
@property (nonatomic, strong) ViewController *homeVc;
@end

@implementation BRMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTotalChildController];
}

- (void)addTotalChildController {
    [self addAloneChildController:self.homeVc title:@"首页"];
}

- (void)addAloneChildController:(UIViewController *)controller title:(NSString *)title{
    controller.title = title;
    BRMainNavigationController *ngVc = [[BRMainNavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:ngVc];
}

- (ViewController *)homeVc {
    if (!_homeVc) {
        _homeVc = [[ViewController alloc] init];
    }
    return _homeVc;
}
@end
