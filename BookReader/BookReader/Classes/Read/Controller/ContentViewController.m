//
//  ContentViewController.m
//  JoeBookPhone
//
//  Created by joe on 2017/5/17.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "ContentViewController.h"
#import "ContentView.h"
@interface ContentViewController ()
@property (nonatomic, strong) ContentView *contentView;
@end

@implementation ContentViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.view addSubview:self.contentView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.contentView.frame = self.view.bounds;
}
- (void)setModel:(BRPageModel *)model
{
    _model = model;
    
    self.contentView.model = model;
}
- (ContentView *)contentView
{
    if (!_contentView) {
        _contentView = [[ContentView alloc] init];
    }
    return _contentView;
}

@end
