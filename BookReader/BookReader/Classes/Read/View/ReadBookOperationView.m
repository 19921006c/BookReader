//
//  ReadBookOperationView.m
//  BookReader
//
//  Created by joe on 2017/5/18.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "ReadBookOperationView.h"
#import "ReadBookOperationDefaultView.h"
#import "ReadBookOperationSettingView.h"
#import "ReadBookOperationLightView.h"
#import "ReadBookOperationSoundView.h"
@interface ReadBookOperationView()
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic, strong) ReadBookOperationDefaultView *defaultView;
@property (nonatomic, strong) ReadBookOperationSettingView *settingView;
@property (nonatomic, strong) ReadBookOperationLightView *lightView;
@property (nonatomic, strong) ReadBookOperationSoundView *soundView;
@end
@implementation ReadBookOperationView
#pragma mark - life cycle
+ (instancetype)operationView
{
    ReadBookOperationView *view = (ReadBookOperationView *)[[NSBundle mainBundle] loadNibNamed:@"ReadBookOperationView" owner:self options:nil].lastObject;
    view.hidden = YES;
    view.type = OperationDefault;
    return view;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.defaultView.frame = self.bounds;
    self.settingView.frame = self.bounds;
    self.lightView.frame = self.bounds;
    self.soundView.frame = self.bounds;
}
#pragma mark - delegate
#pragma mark - event response
- (IBAction)backBtnAction:(id)sender {
    [[BRCommonTool findNearsetViewController:self].navigationController popViewControllerAnimated:YES];
}
- (void)didClick
{
    self.hidden = !self.hidden;
    [[BRCommonTool findNearsetViewController:self] setNeedsStatusBarAppearanceUpdate];
    if (self.hidden) {
        self.type = OperationDefault;
    }
}
#pragma mark - private methods
#pragma mark - getters and setters

- (void)setType:(ReadBookOperationType )type
{
    _type = type;
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    if (type == OperationDefault) {//显示默认view
        [self addSubview:self.defaultView];
        return;
    }
    if (type == OperationSetting) {//显示设置view
        [self addSubview:self.settingView];
        return;
    }
    if (type == OperationLight) {//显示亮度view
        [self addSubview:self.lightView];
        return;
    }
    //显示朗读view
    [self addSubview:self.soundView];
}

- (ReadBookOperationDefaultView *)defaultView
{
    if (!_defaultView) {
        _defaultView = [ReadBookOperationDefaultView defaultView];
    }
    return _defaultView;
}
- (ReadBookOperationSettingView *)settingView
{
    if (!_settingView) {
        _settingView = [ReadBookOperationSettingView settingView];
    }
    return _settingView;
}
- (ReadBookOperationLightView *)lightView
{
    if (!_lightView) {
        _lightView = [ReadBookOperationLightView lightView];
    }
    return _lightView;
}
- (ReadBookOperationSoundView *)soundView
{
    if (!_soundView) {
        _soundView = [ReadBookOperationSoundView soundView];
    }
    return _soundView;
}
@end
