//
//  BRCommonTool.h
//  BookReader
//
//  Created by joe on 2017/5/19.
//  Copyright © 2017年 joe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BRCommonTool : NSObject
/**
 *  找到最近的上一级 ViewController
 *  @param view 当前view
 *  @return 返回当前view所在控制器
 */
+ (UIViewController *)findNearsetViewController:(UIView *)view;
@end
