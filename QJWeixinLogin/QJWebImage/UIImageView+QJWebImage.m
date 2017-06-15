//
//  UIImageView+QJWebImage.m
//  QJWebImage
//
//  Created by 瞿杰 on 2017/5/19.
//  Copyright © 2017年 yiniu. All rights reserved.
//

#import "UIImageView+QJWebImage.h"

#import "QJWebImageManager.h"
#import "QJDownloadProgressView.h"
#import <objc/runtime.h>

@implementation UIImageView (QJWebImage)

static const char QJShowProgressViewKey = '\0';

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.showProgressView = YES ;
    }
    return self ;
}
-(void)setShowProgressView:(BOOL)showProgressView
{
    [self willChangeValueForKey:@"showProgressView"]; // KVO
    objc_setAssociatedObject(self, &QJShowProgressViewKey,
                             @(showProgressView), OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"showProgressView"]; // KVO
}
-(BOOL)isShowProgressView
{
    return [objc_getAssociatedObject(self, &QJShowProgressViewKey) boolValue];
}


-(void)qj_setImageWithURL:(NSURL *)imageURL
{
    [self qj_setImageWithURL:imageURL downloadProgressing:nil downloadFinished:nil];
}
-(void)qj_setImageWithURL:(NSURL *)imageURL placeholderImage:(UIImage *)placeholder
{
    [self qj_setImageWithURL:imageURL placeholderImage:placeholder downloadProgressing:nil downloadFinished:nil];
}

-(void)qj_setImageWithUrlStr:(NSString *)imageUrlStr
{
    [self qj_setImageWithUrlStr:imageUrlStr downloadProgressing:nil downloadFinished:nil];
}
-(void)qj_setImageWithUrlStr:(NSString *)imageUrlStr placeholderImage:(UIImage *)placeholder
{
    [self qj_setImageWithUrlStr:imageUrlStr placeholderImage:placeholder downloadProgressing:nil downloadFinished:nil];
}

-(void)qj_setImageWithUrlStr:(NSString *)imageUrlStr downloadProgressing:(QJDownloadProgressingBlock)downloadProgressing downloadFinished:(QJDownloadFinishedBlock)downloadFinished
{
    if (!imageUrlStr) {
        return ;
    }
    
    [self qj_setImageWithURL:[NSURL URLWithString:imageUrlStr] downloadProgressing:downloadProgressing downloadFinished:downloadFinished];
}
-(void)qj_setImageWithUrlStr:(NSString *)imageUrlStr placeholderImage:(UIImage *)placeholder downloadProgressing:(QJDownloadProgressingBlock)downloadProgressing downloadFinished:(QJDownloadFinishedBlock)downloadFinished
{
    [self qj_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:placeholder downloadProgressing:downloadProgressing downloadFinished:downloadFinished];
}


-(void)qj_setImageWithURL:(NSURL *)imageURL placeholderImage:(UIImage *)placeholder downloadProgressing:(QJDownloadProgressingBlock)downloadProgressing downloadFinished:(QJDownloadFinishedBlock)downloadFinished
{
    if ([placeholder isKindOfClass:[UIImage class]]) {
        self.image = placeholder ;
    }
    
    [self qj_setImageWithURL:imageURL downloadProgressing:downloadProgressing downloadFinished:downloadFinished];
}
-(void)qj_setImageWithURL:(NSURL *)imageURL downloadProgressing:(QJDownloadProgressingBlock)downloadProgressing downloadFinished:(QJDownloadFinishedBlock)downloadFinished
{
    if (!imageURL) {
        return ;
    }
    
    QJDownloadProgressView * progressView = nil ;
    if (self.isShowProgressView) {
        progressView = [[QJDownloadProgressView alloc] init];
        [progressView takeBgBluckViewAddToSuperView:self];
        [self addSubview:progressView];
        progressView.frame = self.bounds ;
    }
    
    QJWeakSelf ;
    
    QJDownloadProgressingBlock progressingBlock = downloadProgressing ;
    
    if (self.isShowProgressView) {
        progressingBlock = ^(CGFloat curDownloadSize , CGFloat didDownloadSize , CGFloat fileSize){
            if (weakSelf.isShowProgressView) {
                progressView.progressScope = 1.0 * didDownloadSize / fileSize ;
            }
            
            if (downloadProgressing) {
                downloadProgressing(curDownloadSize , didDownloadSize , fileSize);
            }
        };
    }
    
    QJDownloadFinishedBlock finished = ^(UIImage * image , NSString * filePath){
        weakSelf.image = image ;
        
        if (downloadFinished) {
            downloadFinished(image,filePath);
        }
    };
    
    [QJWebImageManager startDownloadImageWithURL:imageURL downloadProgressing:progressingBlock downloadFinished:finished];
}

@end
