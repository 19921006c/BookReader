//
//  ViewController.m
//  JoeBookPhone
//
//  Created by joe on 2017/5/17.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "ViewController.h"
#import "ReadBookViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    ReadBookViewController *vc = [[ReadBookViewController alloc] init];
    
    [self presentViewController:vc animated:YES completion:nil];
}

@end
