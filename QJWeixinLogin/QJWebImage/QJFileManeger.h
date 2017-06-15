//
//  QJFileManeger.h
//  QJWebImage
//
//  Created by 瞿杰 on 2017/5/19.
//  Copyright © 2017年 yiniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QJFileManeger : NSObject

// FolderName 如 QJWebImagesFile
+(instancetype)defaultManeger;

// 缓存的公共存储文件路径
+(NSString *)commonFolderPath ;
/**
    图片缓存的根文件名 默认为 @"QJWebImageFile"
 */
@property (nonatomic , copy)NSString * rootFolderName ;

// 移动所在 atURL 位置的文件 到 toURL 所在的位置 , 结果是否移动成功
-(BOOL)moveItemAtPath:(NSString *)atPath toPath:(NSString *)toPath ;
-(BOOL)moveItemAtURL:(NSURL *)atURL toURL:(NSURL *)toURL ;

// 创建文件
-(BOOL)createFileAtFileNameIfNeed:(NSString *)fileName ;

// 删除文件
-(BOOL)removeImageWithImageName:(NSString *)imageName ;
-(BOOL)removeFolder:(NSString *)folderName ;
-(BOOL)removeAllImageCache;

// 文件是否存在
-(BOOL)folderPathIsExist:(NSString *)folderPath ;
-(BOOL)fileIsExist:(NSString *)fileName ;

// 获取文件的大小
-(NSInteger)fileSizeWithFilePath:(NSString *)filePath ;
-(NSInteger)imageFileSizeWithImageName:(NSString *)imageName ;

// 获取文件路径根据图片名称
-(NSString *)getImagePathWithImageName:(NSString *)imageName ;
// 获取图片根据图片名称
-(UIImage *)getImageWithImageName:(NSString *)imageName ;

@end
