//
//  ReadBookOperationLightView.m
//  BookReader
//
//  Created by joe on 2017/5/19.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "ReadBookOperationLightView.h"

@implementation ReadBookOperationLightView

+ (instancetype)lightView
{
    ReadBookOperationLightView *view = [[[NSBundle mainBundle] loadNibNamed:@"ReadBookOperationLightView" owner:self options:nil] lastObject];
    return view;
}

@end
