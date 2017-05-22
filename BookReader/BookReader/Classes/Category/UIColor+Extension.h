//
//  UIColor+Extension.h
//  DoctorPlatForm
//
//  Created by weiyi on 15/4/20.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)
+ (UIColor *) colorWithHexString: (NSString *) hexString;
+ (NSString*) stringWithColor:(UIColor*)color;
@end
