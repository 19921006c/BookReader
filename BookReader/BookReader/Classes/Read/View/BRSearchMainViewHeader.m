//
//  BRSearchMainViewHeader.m
//  BookReader
//
//  Created by joe on 2017/5/24.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "BRSearchMainViewHeader.h"

@interface BRSearchMainViewHeader()
@property (weak, nonatomic) IBOutlet UILabel *label;
@end
@implementation BRSearchMainViewHeader

+ (instancetype)header
{
    BRSearchMainViewHeader *view = [[[NSBundle mainBundle] loadNibNamed:@"BRSearchMainViewHeader" owner:self options:nil] lastObject];
    return view;
}
- (void)setArray:(NSArray *)array
{
    _array = array;
    
    self.label.text = [NSString stringWithFormat:@"已经找到%ld条结果", array.count];
}
@end
