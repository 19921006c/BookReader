//
//  ReadBookOperationDefaultView.m
//  BookReader
//
//  Created by joe on 2017/5/19.
//  Copyright © 2017年 joe. All rights reserved.
//
/** 操作默认页通知PageViewController翻到指定页 */
#define kOperationDefaultViewNTPageViewControllerPage @"kOperationDefaultViewNTPageViewControllerPage"

#import "ReadBookOperationDefaultView.h"
#import "ReadBookOperationView.h"
#import "BRBookModel.h"
#import "BRSearchViewController.h"
@interface ReadBookOperationDefaultView()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *processRateLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;

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
        superView.type = OperationSound;
        return;
    }
    if (tag == 1006) {//夜间
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
@end
