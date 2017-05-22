//
//  ReadBookOperationDefaultView.h
//  BookReader
//
//  Created by joe on 2017/5/19.
//  Copyright © 2017年 joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BRBookModel;
@interface ReadBookOperationDefaultView : UIView

+ (instancetype)defaultView;
@property (nonatomic, strong) BRBookModel *model;

@end
