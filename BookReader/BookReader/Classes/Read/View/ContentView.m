//
//  ContentView.m
//  JoeBookPhone
//
//  Created by joe on 2017/5/15.
//  Copyright © 2017年 joe. All rights reserved.
//
#define kChangeContentViewAttributesKey @"kChangeContentViewAttributesKey"
#define kNightModeUserdefaultsKey @"kNightModeUserdefaultsKey"

#import "ContentView.h"
#import <CoreText/CoreText.h>
@interface ContentView()

@property (nonatomic, strong) UIColor *fontColor;

@property (nonatomic, strong) UIColor *bgColor;

@end
@implementation ContentView

-(instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeContentViewAttributes:) name:kChangeContentViewAttributesKey object:nil];
    }
    return self;
}
- (void)changeContentViewAttributes:(NSNotification *)notification
{
    [[NSUserDefaults standardUserDefaults] setObject:notification.userInfo forKey:kNightModeUserdefaultsKey];
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (!self.model.content) {
        return;
    }
    [self superview].backgroundColor = self.bgColor;
    // 步骤1：得到当前用于绘制画布的上下文，用于后续将内容绘制在画布上
    // 因为Core Text要配合Core Graphic 配合使用的，如Core Graphic一样，绘图的时候需要获得当前的上下文进行绘制
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 步骤2：翻转当前的坐标系（因为对于底层绘制引擎来说，屏幕左下角为（0，0））
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    // 步骤3：创建绘制区域
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect pathFrame = CGRectMake(20, 40, self.bounds.size.width - 20 * 2, self.bounds.size.height - 40 * 2);
    CGPathAddRect(path, NULL, pathFrame);
    //    CGPathAddEllipseInRect(path, NULL, self.bounds);
    // 步骤4：创建需要绘制的文字与计算需要绘制的区域
    NSString *str = self.model.content;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:[str substringWithRange:NSMakeRange(0, str.length)]];
    
    CTFontRef font = CTFontCreateWithName((CFStringRef)[UIFont systemFontOfSize:12].fontName, 12, NULL);
    [attrString addAttribute:(id)kCTFontAttributeName value:(__bridge id)font range:NSMakeRange(0, attrString.length)];
    
//    UIColor *fontColor = [UIColor blackColor];
    [attrString addAttribute:(id)kCTForegroundColorAttributeName value:(id)self.fontColor.CGColor range:NSMakeRange(0, attrString.length)];
    
    // 步骤5：根据AttributedString生成CTFramesetterRef
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, [attrString length]), path, NULL);
    
    // 步骤6：进行绘制
    CTFrameDraw(frame, context);
    // 步骤7.内存管理
    CFRelease(frame);
    CFRelease(path);
    CFRelease(frameSetter);
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIColor *)fontColor
{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:kNightModeUserdefaultsKey];
    
    UIColor *color = [UIColor colorWithHexString:dic[@"fontColor"]];
    
    if (!color) {
        color = [UIColor blackColor];
    }
    return color;
}
- (UIColor *)bgColor
{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:kNightModeUserdefaultsKey];
    UIColor *color = [UIColor colorWithHexString:dic[@"bgColor"]];
    if (!color) {
        color = [UIColor whiteColor];
    }
    return color;
}
@end
