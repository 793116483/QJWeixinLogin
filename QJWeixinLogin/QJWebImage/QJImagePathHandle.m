//
//  QJImagePathHandle.m
//  QJWebImage
//
//  Created by 瞿杰 on 2017/5/19.
//  Copyright © 2017年 yiniu. All rights reserved.
//

#import "QJImagePathHandle.h"

@implementation QJImagePathHandle

+(NSString *)imageNameForBase64Handle:(NSString *)path
{
    NSData * data = [path dataUsingEncoding:NSUTF8StringEncoding];
    NSString * imageNameBase = [data base64EncodedStringWithOptions:0];
    return [imageNameBase substringToIndex:imageNameBase.length - 2];
}

@end
