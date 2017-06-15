//
//  QJImagePathHandle.h
//  QJWebImage
//
//  Created by 瞿杰 on 2017/5/19.
//  Copyright © 2017年 yiniu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJImagePathHandle : NSObject

/**
 *  将路径或者url转成base64处理的字符串
 *
 *  @param path 需要处理的字符串
 *
 *  @return 处理完毕的字符串
 */
+ (NSString *)imageNameForBase64Handle:(NSString *)path;

@end
