//
//  BRPageModel.m
//  BookReader
//
//  Created by joe on 2017/5/18.
//  Copyright © 2017年 joe. All rights reserved.
//

#import "BRPageModel.h"

@implementation BRPageModel
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.index = [aDecoder decodeIntegerForKey:@"index"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeInteger:self.index forKey:@"index"];
}
@end
