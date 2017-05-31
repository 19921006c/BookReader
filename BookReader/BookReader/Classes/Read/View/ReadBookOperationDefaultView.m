//
//  ReadBookOperationDefaultView.m
//  BookReader
//
//  Created by joe on 2017/5/19.
//  Copyright © 2017年 joe. All rights reserved.
//
/** 操作默认页通知PageViewController翻到指定页 */
#define kOperationDefaultViewNTPageViewControllerPage @"kOperationDefaultViewNTPageViewControllerPage"
#define kChangeContentViewAttributesKey @"kChangeContentViewAttributesKey"
#define kNightModeUserdefaultsKey @"kNightModeUserdefaultsKey"

#import "ReadBookOperationDefaultView.h"
#import "ReadBookOperationView.h"
#import "BRBookModel.h"
#import "BRSearchViewController.h"
#import "BDSSpeechSynthesizer.h"
@interface ReadBookOperationDefaultView()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *processRateLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;
/**
 *  YES : 选择夜间模式
 *  NO  : 未选择夜间模式
 */
@property (nonatomic, assign) BOOL nightModelMark;
@property (weak, nonatomic) IBOutlet UIButton *nightModeBtn;

/**
 *  YES : 正在朗读
 *  NO  : 未朗读
 */
@property (nonatomic, assign) BOOL isReadingMark;
/**
 *  朗读btn
 */
@property (weak, nonatomic) IBOutlet UIButton *soundBtn;


@end
@implementation ReadBookOperationDefaultView

+ (instancetype)defaultView
{
    ReadBookOperationDefaultView *view = [[[NSBundle mainBundle] loadNibNamed:@"ReadBookOperationDefaultView" owner:self options:nil] lastObject];
    
    return view;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 100;
    [self.slider addTarget:self action:@selector(changeProcessRateValue:) forControlEvents:UIControlEventValueChanged];
    [self.slider addTarget:self action:@selector(scrollEnd:) forControlEvents:UIControlEventTouchUpInside];
    [self.model addObserver:self forKeyPath:@"recordPageNum" options:NSKeyValueObservingOptionNew context:nil];
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:kNightModeUserdefaultsKey];
    self.nightModelMark = [dic[@"isNight"] boolValue];
}
- (void)scrollEnd:(UISlider *)slider
{
    NSUInteger pageNum = self.model.pageModelArray.count * slider.value * 0.01;
    
    NSDictionary *dic = @{@"pageNum" : [NSString stringWithFormat:@"%ld", pageNum]};
    [[NSNotificationCenter defaultCenter] postNotificationName:kOperationDefaultViewNTPageViewControllerPage object:nil userInfo:dic];
}
- (void)changeProcessRateValue:(UISlider *)slider
{
    self.processRateLabel.text = [NSString stringWithFormat:@"%.2f%%", slider.value];
}

- (IBAction)btnAction:(UIButton *)sender {
    
    NSInteger tag = sender.tag;
    ReadBookOperationView *superView = (ReadBookOperationView *)[self superview];
    if (tag == 1001) {//返回
        [[BRCommonTool findNearsetViewController:self].navigationController popViewControllerAnimated:YES];
        return;
    }
    if (tag == 1002) {//搜索
        BRSearchViewController *vc = [[BRSearchViewController alloc] init];
        vc.model = self.model;
        [[BRCommonTool findNearsetViewController:self].navigationController pushViewController:vc animated:YES];
        return;
    }
    if (tag == 1003) {//设置
        superView.type = OperationSetting;
        return;
    }
    if (tag == 1004) {//亮度
        superView.type = OperationLight;
        return;
    }
    if (tag == 1005) {//朗读
//        superView.type = OperationSound;
        self.isReadingMark = !self.isReadingMark;
        return;
    }
    if (tag == 1006) {//夜间
        self.nightModelMark = !self.nightModelMark;
        return;
    }
    if (tag == 1007) {//减进度
        return;
    }
    //加进度
}

- (void)setModel:(BRBookModel *)model
{
    _model = model;
    
    CGFloat rate = (CGFloat)model.recordPageNum / (model.pageModelArray.count - 1) * 100;
    [self.slider setValue:rate];
    self.processRateLabel.text = [NSString stringWithFormat:@"%.2f%%", rate];
    self.titleLabel.text = model.title;
}
- (void)setNightModelMark:(BOOL)nightModelMark
{
    _nightModelMark = nightModelMark;
    
    //设置夜间模式btn样式
    UIImage *image;
    NSDictionary *dic;
    NSString *fontColor;
    NSString *bgColor;
    NSString *isNight;
    if (nightModelMark) {
        image = [UIImage imageNamed:@"textReading_night_high"];
        fontColor = @"#FFFFFF";
        bgColor = @"#000000";
        isNight = @"YES";
    } else {
        image = [UIImage imageNamed:@"textReading_night"];
        fontColor = @"#000000";
        bgColor = @"#FFFFFF";
        isNight = @"NO";
    }
    [self.nightModeBtn setImage:image forState:UIControlStateNormal];
    //通知ContentView重绘
    dic = @{@"fontColor" : fontColor,
            @"bgColor"   : bgColor,
            @"isNight"   : isNight};
    [[NSNotificationCenter defaultCenter] postNotificationName:kChangeContentViewAttributesKey object:nil userInfo:dic];
}

- (void)setIsReadingMark:(BOOL)isReadingMark
{
    _isReadingMark = isReadingMark;
    
    
    // 设置apiKey和secretKey
    [[BDSSpeechSynthesizer sharedInstance] setApiKey:@"DdCXZ8EjtBDmgkqqMVnTn1NX" withSecretKey:@"Y5L6kIPtZfb2ufkIfzY8XdD1EDNY0DHm"];
    
    // 设置离线引擎
    NSString *ChineseSpeechData = [[NSBundle mainBundle] pathForResource:@"Chinese_Speech_Female" ofType:@"dat"];
    NSString *ChineseTextData = [[NSBundle mainBundle] pathForResource:@"Chinese_text" ofType:@"dat"];
    NSString *EnglishSpeechData = [[NSBundle mainBundle] pathForResource:@"English_Speech_Female" ofType:@"dat"];
    NSString *EnglishTextData = [[NSBundle mainBundle] pathForResource:@"English_text" ofType:@"dat"];
    NSString *LicenseData = [[NSBundle mainBundle] pathForResource:@"bdtts_license" ofType:@"dat"];
//    NSError* loadErr = [[BDSSpeechSynthesizer sharedInstance] startTTSEngine:ChineseTextData                                    speechDataPath:ChineseSpeechData
//                                                             licenseFilePath:LicenseData withAppCode:@""];
    NSError* loadErr = [[BDSSpeechSynthesizer sharedInstance] loadOfflineEngine:ChineseTextData speechDataPath:ChineseSpeechData licenseFilePath:LicenseData withAppCode:@""];
    if(loadErr != nil)
    {
        // 处理出错状况
    }
    
    // 加载英文资源
//    loadErr = [[BDSSpeechSynthesizer sharedInstance] loadEnglishData:EnglishTextData speechData:EnglishSpeechData];
    loadErr = [[BDSSpeechSynthesizer sharedInstance] loadEnglishDataForOfflineEngine:EnglishTextData speechData:EnglishSpeechData];
    if(loadErr != nil)
    {
        // 处理出错状况
    }
    
    // 获得合成器实例
    [[BDSSpeechSynthesizer sharedInstance] setSynthesizerDelegate:self];
    
    // 设置委托对象
    [[BDSSpeechSynthesizer sharedInstance] setSynthesizerDelegate:self];
    
    // 开始合成并播放
    NSError* speakError = nil;
    if([[BDSSpeechSynthesizer sharedInstance] speakSentence:@"您好" withError:&speakError] == -1){
        // 错误
        NSLog(@"错误: %ld, %@", (long)speakError.code, speakError.localizedDescription);
    }
    if([[BDSSpeechSynthesizer sharedInstance] speakSentence:@"今天天气真不错" withError:&speakError] == -1){
        // 错误
        NSLog(@"错误: %ld, %@", (long)speakError.code, speakError.localizedDescription);
    }
    if([[BDSSpeechSynthesizer sharedInstance] speakSentence:@"Today's weather is really good!" withError:&speakError] == -1){
        // 错误
        NSLog(@"错误: %ld, %@", (long)speakError.code, speakError.localizedDescription);
    }
}
@end
