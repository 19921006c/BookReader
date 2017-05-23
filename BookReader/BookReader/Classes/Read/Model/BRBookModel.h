//
//  BRBookModel.h
//  BookReader
//
//  Created by joe on 2017/5/18.
//  Copyright © 2017年 joe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRBookModel : NSObject<NSCoding>

/** 书名 */
@property (nonatomic, copy) NSString *title;
/** 整本书的内容 */
@property (nonatomic, copy) NSString *content;
/** 每一页的pageModel数组 */
@property (nonatomic, strong) NSMutableArray *pageModelArray;
/** 读书进度记录 */
@property (nonatomic, assign) NSUInteger recordPageNum;

@end
