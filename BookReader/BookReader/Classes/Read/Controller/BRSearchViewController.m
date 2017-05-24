//
//  BRSearchViewController.m
//  BookReader
//
//  Created by joe on 2017/5/23.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "BRSearchViewController.h"
#import "BRSearchMainView.h"
@interface BRSearchViewController ()
@property (nonatomic, strong) BRSearchMainView *searchView;
@end

@implementation BRSearchViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.view addSubview:self.searchView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.searchView.frame = self.view.bounds;
}
#pragma mark - delegate
#pragma mark - event response
#pragma mark - private methods
#pragma mark - getters and setters
- (BRSearchMainView *)searchView
{
    if (!_searchView) {
        _searchView = [[[NSBundle mainBundle] loadNibNamed:@"BRSearchMainView" owner:self options:nil] lastObject];
    }
    return _searchView;
}
- (void)setModel:(BRBookModel *)model
{
    _model = model;
    
    self.searchView.model = model;
}
@end
