//
//  BRPageViewController.h
//  BookReader
//
//  Created by joe on 2017/5/18.
//  Copyright © 2017年 joe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BRBookModel;
@interface BRPageViewController : UIPageViewController
@property (nonatomic, strong) BRBookModel *model;
@end
