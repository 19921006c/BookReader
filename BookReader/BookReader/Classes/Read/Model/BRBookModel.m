//
//  BRBookModel.m
//  BookReader
//
//  Created by joe on 2017/5/18.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "BRBookModel.h"
#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>
#import "BRPageModel.h"
@implementation BRBookModel

- (void)setContent:(NSString *)content
{
    _content = content;
   
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:content];
    CTFontRef font = CTFontCreateWithName((CFStringRef)[UIFont systemFontOfSize:12].fontName, 12, NULL);
    [attributedStr addAttribute:(id)kCTFontAttributeName value:(__bridge id)font range:NSMakeRange(0, attributedStr.length)];
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGRect pathFrame = CGRectMake(20, 40, kReadViewWidth, kReadViewHeight);
    CGPathAddRect(path, NULL, pathFrame);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedStr);
    
    int page = 0;
    int currentLocation = 0;
    BOOL notEnding = YES;
    while (notEnding) {
        CTFrameRef tmpFrame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(currentLocation, 0), path, NULL);
        CFRange tmpRange = CTFrameGetVisibleStringRange(tmpFrame);
        currentLocation += tmpRange.length;
        page ++;
        if (tmpRange.location + tmpRange.length >= attributedStr.length) {
            notEnding = NO;
        }
        
        BRPageModel *model = [[BRPageModel alloc] init];
        model.content = [content substringWithRange:NSMakeRange(tmpRange.location, tmpRange.length)];
        [self.pageModelArray addObject:model];
        
        if (tmpFrame) CFRelease(tmpFrame);
    }
    
    CGPathRelease(path);
    CFRelease(frameSetter);
    
}

- (NSMutableArray *)pageModelArray
{
    if (!_pageModelArray) {
        _pageModelArray = [NSMutableArray array];
    }
    return _pageModelArray;
}

@end
