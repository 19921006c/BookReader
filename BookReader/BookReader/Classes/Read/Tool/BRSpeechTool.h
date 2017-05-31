//
//  BRSpeechTool.h
//  BookReader
//
//  Created by joe on 2017/5/31.
//  Copyright © 2017年 joe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDSSpeechSynthesizerDelegate.h"
@interface BRSpeechTool : NSObject<BDSSpeechSynthesizerDelegate>

+ (void)configureSDK;

@end
