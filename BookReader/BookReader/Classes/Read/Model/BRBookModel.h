//
//  BRBookModel.h
//  BookReader
//
//  Created by joe on 2017/5/18.
//  Copyright © 2017年 joe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRBookModel : NSObject

/** 整本书的内容 */
@property (nonatomic, copy) NSString *content;
/** 每一页的pageModel数组 */
@property (nonatomic, strong) NSMutableArray *pageModelArray;

@end
