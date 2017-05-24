//
//  BRPageModel.h
//  BookReader
//
//  Created by joe on 2017/5/18.
//  Copyright © 2017年 joe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRPageModel : NSObject<NSCoding>
/** 当前页内容 */
@property (nonatomic, copy) NSString *content;
/** 当前页数 */
@property (nonatomic, assign) NSUInteger index;
@end
