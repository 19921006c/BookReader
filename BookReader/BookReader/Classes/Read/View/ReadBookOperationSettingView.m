//
//  ReadBookOperationSettingView.m
//  BookReader
//
//  Created by joe on 2017/5/19.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "ReadBookOperationSettingView.h"

@implementation ReadBookOperationSettingView

+ (instancetype)settingView
{
    ReadBookOperationSettingView *view = [[[NSBundle mainBundle] loadNibNamed:@"ReadBookOperationSettingView" owner:self options:nil] lastObject];
    return view;
}

@end
