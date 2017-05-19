//
//  BRCommonTool.m
//  BookReader
//
//  Created by joe on 2017/5/19.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "BRCommonTool.h"

@implementation BRCommonTool
+ (UIViewController *)findNearsetViewController:(UIView *)view {
    UIViewController *viewController = nil;
    for (UIView *next = view; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            viewController = (UIViewController *)nextResponder;
            break;
        }
    }
    return viewController;
}
@end
