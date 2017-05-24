//
//  BRReadBookTool.h
//  BookReader
//
//  Created by joe on 2017/5/23.
//  Copyright © 2017年 joe. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BRBookModel;
@interface BRReadBookTool : NSObject

/** 将model放入缓存
 *  @param model 需要放入缓存的model
 */
+ (void)saveDataWithModel:(BRBookModel *)model;

/** 获取文件model
 *  @param fileName 文件名称
 *  @return 返回model
 */
+ (BRBookModel *)getModelWithFileName:(NSString *)fileName;

/**
 *  @param target 目标字符串
 *  @param model  书本model
 *  @return 返回结果model的数组
 */
+ (NSArray *)searchTargetWithStr:(NSString *)target model:(BRBookModel *)model;

+ (NSArray *)getTotalBookList;
@end
