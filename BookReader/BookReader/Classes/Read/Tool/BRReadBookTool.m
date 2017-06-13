//
//  BRReadBookTool.m
//  BookReader
//
//  Created by joe on 2017/5/23.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "BRReadBookTool.h"
#import "BRBookModel.h"
#import "BRPageModel.h"
#import "BRSearchModel.h"
@implementation BRReadBookTool

+ (void)saveDataWithModel:(BRBookModel *)model
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data", model.title]];
    
    [NSKeyedArchiver archiveRootObject:model toFile:filePath];
}
+ (BRBookModel *)getModelWithFileName:(NSString *)fileName
{
    //1. 先从本地看时候有缓存记录
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data", fileName]];
    
    BRBookModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    //2. 有缓存记录则返回model
    if (model) return model;
    
    //3. 没有缓存记录, 创建model
    filePath = [documentPath stringByAppendingPathComponent:fileName];
    NSString *content = [self contentWithFilePath:filePath];
    model = [[BRBookModel alloc] init];
    model.title = fileName;
    model.content = content;
    
    //4. 将model缓存到本地
    [BRReadBookTool saveDataWithModel:model];
    
    return model;
}

+ (NSString *)contentWithFilePath:(NSString *)filePath
{
    NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    if (!content) {
        content = [NSString stringWithContentsOfFile:filePath encoding:0x80000632 error:nil];
    }
    if (!content) {
        content = [NSString stringWithContentsOfFile:filePath encoding:0x80000631 error:nil];
    }
    
    if (!content) {
        return nil;
    }
    return content;
}
+ (NSArray *)searchTargetWithStr:(NSString *)target model:(BRBookModel *)model
{
    NSMutableArray *matchMulArray = [NSMutableArray array];
    for (BRPageModel *pageModel in model.pageModelArray) {
        NSString *content = pageModel.content;
        while ([content rangeOfString:target].location != NSNotFound) {
            NSRange tmpRange = [content rangeOfString:target];
            NSRange matchRange = NSMakeRange(tmpRange.location, tmpRange.length + 10);
            NSString *matchStr = [content substringWithRange:matchRange];
            
            NSUInteger fromIndex = tmpRange.location + tmpRange.length;
            content = [content substringFromIndex:fromIndex];
            
            BRSearchModel *searchModel = [[BRSearchModel alloc] init];
            searchModel.content = matchStr;
            searchModel.index = pageModel.index;
            [matchMulArray addObject:searchModel];
        }
    }
    return matchMulArray;
}

+ (NSArray *)getTotalBookList
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *array = [manager contentsOfDirectoryAtPath:documentPath error:nil];
    NSMutableArray *mulArray = [NSMutableArray array];
    for (NSString *str in array) {
        if ([str hasSuffix:@".txt"]) {
            [mulArray addObject:str];
        }
    }
    
    //没有任何数据时, 添加默认数据
    if (mulArray.count == 0) {
        NSString *defaultFileName = @"花间提壶方大厨.txt";
        NSString *path = [[NSBundle mainBundle] pathForResource:defaultFileName ofType:nil];
        NSString *content = [self contentWithFilePath:path];
        
        BRBookModel *model = [[BRBookModel alloc] init];
        model.title = defaultFileName;
        model.content = content;
        
        //4. 将model缓存到本地
        [BRReadBookTool saveDataWithModel:model];
        [mulArray addObject:defaultFileName];
    }
    return mulArray;
}
@end
