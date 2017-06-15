//
//  CommentHeader.h
//  QJWebImage
//
//  Created by 瞿杰 on 2017/5/19.
//  Copyright © 2017年 yiniu. All rights reserved.
//

#ifndef CommentHeader_h
#define CommentHeader_h

/**
 下载图片的进度

 @param curDownloadSize 当前一步下载的大小 kb
 @param didDownloadSize 已经下载好了的大小 kb
 @param fileSize 图片所占内存的大小 kb
 */
typedef void(^QJDownloadProgressingBlock)(CGFloat curDownloadSize , CGFloat didDownloadSize , CGFloat fileSize);

/**
 下载图片完成

 @param image 下载好的图片
 @param filePath 下载好的图片存储在本地路径
 */
typedef void(^QJDownloadFinishedBlock)(UIImage * image , NSString * filePath);


#define QJWeakSelf __weak typeof(self) weakSelf = self


#endif /* CommentHeader_h */
