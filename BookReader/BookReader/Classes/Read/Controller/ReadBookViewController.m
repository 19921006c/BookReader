//
//  ReadBookViewController.m
//  JoeBookPhone
//
//  Created by joe on 2017/5/17.
//  Copyright © 2017年 joe. All rights reserved.
//
#define kAppLightKey @"kAppLightKey"
#define kChangeBrightnessValue @"kChangeBrightnessValue"
#define kReadBookViewController
#import "ReadBookViewController.h"
#import "BRPageViewController.h"
#import "ReadBookOperationView.h"
@interface ReadBookViewController ()<UIGestureRecognizerDelegate>

/** 每一页controller */
@property (nonatomic, strong) BRPageViewController *pageViewController;
/** 操作view(返回, 搜索, 设置等button界面) */
@property (nonatomic, strong) ReadBookOperationView *operationView;
/** 调节亮度Layer */
@property (nonatomic, strong) CALayer *brightnessLayer;
@end

@implementation ReadBookViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.view addSubview:self.operationView];
    [self.view.layer addSublayer:self.brightnessLayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(brightnessChange:) name:kChangeBrightnessValue object:nil];
   
    //添加一个点击手势,
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleClickEvent)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.pageViewController.view.frame = self.view.bounds;
    self.operationView.frame = self.view.bounds;
    self.brightnessLayer.frame = self.view.bounds;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
//根据操作view的hidden属性来判断是否隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return self.operationView.hidden;
}
// 设置状态栏为白色style
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //点击以下几种view才会触发点击事件
    NSString *classStr = [NSString stringWithFormat:@"%@", [touch.view class]];
    if ([classStr isEqualToString:@"ContentView"] ||
        [classStr isEqualToString:@"ReadBookOperationView"] ||
        [classStr isEqualToString:@"ReadBookOperationDefaultView"] ||
        [classStr isEqualToString:@"ReadBookOperationSettingView"] ||
        [classStr isEqualToString:@"ReadBookOperationLightView"] ||
        [classStr isEqualToString:@"ReadBookOperationSoundView"]) {
        return YES;
    }
    /** 点击搜索按钮 */
    if (touch.view.tag == 1002) {
        [self.operationView didClick];
    }
    return NO;
}
#pragma mark - event response
- (void)close {
    [self.navigationController popViewControllerAnimated:YES];
}
/** 调节亮度通知 */
- (void)brightnessChange:(NSNotification *)notification
{
    CGFloat value = [notification.userInfo[@"value"] floatValue];
    self.brightnessLayer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:value].CGColor;
}
#pragma mark - private methods
- (void)singleClickEvent
{
    [self.operationView didClick];
}
#pragma mark - getters and setters
- (BRPageViewController *)pageViewController
{
    if (!_pageViewController) {
        NSDictionary *options = @{UIPageViewControllerOptionInterPageSpacingKey : @(1)};
        _pageViewController = [[BRPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    }
    return _pageViewController;
}
- (void)setModel:(BRBookModel *)model
{
    _model = model;
    
    self.pageViewController.model = model;
    self.operationView.model = model;
}
- (ReadBookOperationView *)operationView
{
    if (!_operationView) {
        _operationView = [ReadBookOperationView operationView];
    }
    return _operationView;
}
- (CALayer *)brightnessLayer
{
    if (!_brightnessLayer) {
        if (!_brightnessLayer) {
            _brightnessLayer = [[CALayer alloc] init];
            CGFloat appLight = [[NSUserDefaults standardUserDefaults] floatForKey:kAppLightKey];
            _brightnessLayer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:appLight].CGColor;
        }
    }
    return _brightnessLayer;
}
@end
