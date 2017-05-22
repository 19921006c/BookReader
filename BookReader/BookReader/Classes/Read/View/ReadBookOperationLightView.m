//
//  ReadBookOperationLightView.m
//  BookReader
//
//  Created by joe on 2017/5/19.
//  Copyright © 2017年 joe. All rights reserved.
//
#define kMaxTransparent 0.5f
#define kAppLightKey @"kAppLightKey"
#define kChangeBrightnessValue @"kChangeBrightnessValue"

#import "ReadBookOperationLightView.h"

@interface ReadBookOperationLightView()
@property (weak, nonatomic) IBOutlet UISlider *slider;
/** 保存改变钱的亮度 */
@property (nonatomic, assign) CGFloat oldBrightness;
@end
@implementation ReadBookOperationLightView

+ (instancetype)lightView
{
    ReadBookOperationLightView *view = [[[NSBundle mainBundle] loadNibNamed:@"ReadBookOperationLightView" owner:self options:nil] lastObject];
    return view;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.slider.minimumTrackTintColor = [UIColor colorWithHexString:@"#34BE99"];
    self.slider.maximumTrackTintColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [self.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.slider.minimumValue = 0.5;
    self.slider.maximumValue = 1.0;
    CGFloat value = [[NSUserDefaults standardUserDefaults] floatForKey:kAppLightKey];
    self.slider.value = 1.0 - value;
}

- (void)sliderValueChanged:(UISlider *)slider
{
    CGFloat value = 1.0 - slider.value;
    NSDictionary *dic = @{@"value" : [NSString stringWithFormat:@"%f", value]};
    [[NSNotificationCenter defaultCenter] postNotificationName:kChangeBrightnessValue object:nil userInfo:dic];
    [[NSUserDefaults standardUserDefaults] setFloat:value forKey:kAppLightKey];
}

@end
