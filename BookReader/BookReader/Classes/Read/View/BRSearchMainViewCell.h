//
//  BRSearchMainViewCell.h
//  BookReader
//
//  Created by joe on 2017/5/24.
//  Copyright © 2017年 joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BRSearchModel;
@interface BRSearchMainViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) BRSearchModel *model;

@end
