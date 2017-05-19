//
//  ReadBookOperationView.m
//  BookReader
//
//  Created by joe on 2017/5/18.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "ReadBookOperationView.h"
@interface ReadBookOperationView()
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end
@implementation ReadBookOperationView

+ (instancetype)operationView
{
    ReadBookOperationView *view = (ReadBookOperationView *)[[NSBundle mainBundle] loadNibNamed:@"ReadBookOperationView" owner:self options:nil].lastObject;
    view.hidden = YES;
    return view;
}

- (IBAction)backBtnAction:(id)sender {
    [[BRCommonTool findNearsetViewController:self].navigationController popViewControllerAnimated:YES];
}
- (void)didClick
{
    self.hidden = !self.hidden;
    [[BRCommonTool findNearsetViewController:self] setNeedsStatusBarAppearanceUpdate];
}
@end
