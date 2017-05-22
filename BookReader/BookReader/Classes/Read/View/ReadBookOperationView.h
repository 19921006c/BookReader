//
//  ReadBookOperationView.h
//  BookReader
//
//  Created by joe on 2017/5/18.
//  Copyright © 2017年 joe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ReadBookOperationType) {
    OperationDefault,
    OperationSetting,
    OperationLight,
    OperationSound,
};

@class BRBookModel;
@interface ReadBookOperationView : UIView
+ (instancetype)operationView;
/** 传递点击时间, 点击ReadBookViewController 的view后传递过来 */
- (void)didClick;
@property (nonatomic) ReadBookOperationType type;
@property (nonatomic, strong) BRBookModel *model;
@end
