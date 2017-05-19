//
//  ReadBookOperationSoundView.m
//  BookReader
//
//  Created by joe on 2017/5/19.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "ReadBookOperationSoundView.h"

@implementation ReadBookOperationSoundView

+ (instancetype)soundView
{
    ReadBookOperationSoundView *view = [[[NSBundle mainBundle] loadNibNamed:@"ReadBookOperationSoundView" owner:self options:nil] lastObject];
    return view;
}

@end
