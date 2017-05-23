//
//  BRReadBookTool.m
//  BookReader
//
//  Created by joe on 2017/5/23.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "BRReadBookTool.h"
#import "BRBookModel.h"
@implementation BRReadBookTool

+ (void)saveDataWithModel:(BRBookModel *)model
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingString:model.title];
    
    [NSKeyedArchiver archiveRootObject:model toFile:filePath];
}
+ (BRBookModel *)getModelWithFileName:(NSString *)fileName
{
    //1. 先从本地看时候有缓存记录
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingString:fileName];
    
    BRBookModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    //2. 有缓存记录则返回model
    if (model) return model;
    
    //3. 没有缓存记录, 创建model
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:0x80000632 error:nil];
    model = [[BRBookModel alloc] init];
    model.title = fileName;
    model.content = content;
    
    //4. 将model缓存到本地
    [BRReadBookTool saveDataWithModel:model];
    
    return model;
}

@end
