//
//  ReadBookOperationDefaultView.m
//  BookReader
//
//  Created by joe on 2017/5/19.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "ReadBookOperationDefaultView.h"

@implementation ReadBookOperationDefaultView

+ (instancetype)defaultView
{
    ReadBookOperationDefaultView *view = [[[NSBundle mainBundle] loadNibNamed:@"ReadBookOperationDefaultView" owner:self options:nil] lastObject];
    return view;
}

@end
