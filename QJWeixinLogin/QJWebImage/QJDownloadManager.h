//
//  QJDownloadManager.h
//  QJWebImage
//
//  Created by 瞿杰 on 2017/5/19.
//  Copyright © 2017年 yiniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CommentHeader.h"

@interface QJDownloadManager : NSObject

+(instancetype)downloadManeger;

-(void)startDownloadImageWithURL:(NSURL *)imageURL ;
-(void)startDownloadImageWithPath:(NSString *)imagePath ;

// 设置回调的 block
// 1.下载进度
-(void)setDownloadProgressing:(QJDownloadProgressingBlock)downloadProgressing ;
// 2.下载完成
-(void)setDownloadFinished:(QJDownloadFinishedBlock)downloadFinished ;

@end
