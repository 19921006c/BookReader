//
//  BRSearchMainViewCell.m
//  BookReader
//
//  Created by joe on 2017/5/24.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "BRSearchMainViewCell.h"
#import "BRSearchModel.h"
@interface BRSearchMainViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
@implementation BRSearchMainViewCell

static NSString *const identifier = @"BRSearchMainViewCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    BRSearchMainViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
    }
    return cell;
}


- (void)setModel:(BRSearchModel *)model
{
    _model = model;
    
    self.label.text = model.content;
}

@end
