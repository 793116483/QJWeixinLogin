//
//  UIImageView+QJWebImage.h
//  QJWebImage
//
//  Created by 瞿杰 on 2017/5/19.
//  Copyright © 2017年 yiniu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentHeader.h"

@interface UIImageView (QJWebImage)

/**
    是否显示进度的 View
 */
@property (nonatomic , getter=isShowProgressView)BOOL showProgressView ;



/**
    加载图片
 
    imageURL         : 图片路径的 URL
    placeholderImage : 占位图
 */
-(void)qj_setImageWithURL:(NSURL *)imageURL  ;
-(void)qj_setImageWithURL:(NSURL *)imageURL placeholderImage:(UIImage *)placeholder ;

/**
    加载图片
 
    imageUrlStr      : 图片路径的 urlStr
    placeholderImage : 占位图
 */
-(void)qj_setImageWithUrlStr:(NSString *)imageUrlStr ;
-(void)qj_setImageWithUrlStr:(NSString *)imageUrlStr placeholderImage:(UIImage *)placeholder ;

/**
    加载图片
 
    imageURL            : 图片路径的       URL
    downloadProgressing : 下载进度过程调用的 block
    downloadFinished    : 下载完成后调用的   block
 */
-(void)qj_setImageWithURL:(NSURL *)imageURL downloadProgressing:(QJDownloadProgressingBlock)downloadProgressing downloadFinished:(QJDownloadFinishedBlock)downloadFinished;

/**
    加载图片
 
    imageURL            : 图片路径的       URL
    placeholderImage    : 占位图
    downloadProgressing : 下载进度过程调用的 block
    downloadFinished    : 下载完成后调用的   block
 */
-(void)qj_setImageWithURL:(NSURL *)imageURL placeholderImage:(UIImage *)placeholder downloadProgressing:(QJDownloadProgressingBlock)downloadProgressing downloadFinished:(QJDownloadFinishedBlock)downloadFinished;


/**
    加载图片
    
    imageUrlStr         : 图片路径的       urlStr
    downloadProgressing : 下载进度过程调用的 block
    downloadFinished    : 下载完成后调用的   block
 */
-(void)qj_setImageWithUrlStr:(NSString *)imageUrlStr downloadProgressing:(QJDownloadProgressingBlock)downloadProgressing downloadFinished:(QJDownloadFinishedBlock)downloadFinished;
/**
    加载图片
 
    imageUrlStr         : 图片路径的       urlStr
    placeholderImage    : 占位图
    downloadProgressing : 下载进度过程调用的 block
    downloadFinished    : 下载完成后调用的   block
 */
-(void)qj_setImageWithUrlStr:(NSString *)imageUrlStr placeholderImage:(UIImage *)placeholder downloadProgressing:(QJDownloadProgressingBlock)downloadProgressing downloadFinished:(QJDownloadFinishedBlock)downloadFinished;

@end
