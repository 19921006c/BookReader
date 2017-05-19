//
//  ReadBookOperationDefaultView.m
//  BookReader
//
//  Created by joe on 2017/5/19.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "ReadBookOperationDefaultView.h"
#import "ReadBookOperationView.h"
@implementation ReadBookOperationDefaultView

+ (instancetype)defaultView
{
    ReadBookOperationDefaultView *view = [[[NSBundle mainBundle] loadNibNamed:@"ReadBookOperationDefaultView" owner:self options:nil] lastObject];
    return view;
}

- (IBAction)btnAction:(UIButton *)sender {
    
    ReadBookOperationView *superView = (ReadBookOperationView *)[self superview];
    if (sender.tag == 1001) {//设置
        superView.type = OperationSetting;
        return;
    }
    if (sender.tag == 1002) {
        superView.type = OperationLight;
        return;
    }
    if (sender.tag == 1003) {
        superView.type = OperationSound;
        return;
    }
    
}


@end
