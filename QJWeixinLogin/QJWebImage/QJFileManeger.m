//
//  QJFileManeger.m
//  QJWebImage
//
//  Created by 瞿杰 on 2017/5/19.
//  Copyright © 2017年 yiniu. All rights reserved.
//

#import "QJFileManeger.h"

@interface QJFileManeger ()

@property (nonatomic , strong)NSFileManager * fileManager;

@end

@implementation QJFileManeger

static QJFileManeger * _currentFileManager ;
#define kCommonFolderName @"QJWebImageCache"
#define kRootFolderName @"QJWebImageFile"

+(instancetype)defaultManeger
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _currentFileManager = [[self alloc] init];
        _currentFileManager.fileManager = [NSFileManager defaultManager];
        _currentFileManager.rootFolderName = kRootFolderName ;
    });

    return _currentFileManager;
}

+(NSString *)documentPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

+(NSString *)commonFolderPath
{
    return [[self documentPath] stringByAppendingPathComponent:kCommonFolderName];
}

-(NSString *)currentCacheFolder
{
    return [[QJFileManeger commonFolderPath] stringByAppendingPathComponent:self.rootFolderName];
}

-(void)setRootFolderName:(NSString *)rootFolderName
{
    if (rootFolderName) {
        _rootFolderName = rootFolderName ;
    }
    
    [self createFileAtFileNameIfNeed:rootFolderName];
}

-(BOOL)moveItemAtPath:(NSString *)atPath toPath:(NSString *)toPath
{
    if (!atPath || !toPath) {
        return NO ;
    }
    
    return [self.fileManager moveItemAtPath:atPath toPath:toPath error:nil] ;
}
-(BOOL)moveItemAtURL:(NSURL *)atURL toURL:(NSURL *)toURL
{
    if (!atURL.path || !toURL.path) {
        return NO ;
    }
    
    return [self.fileManager moveItemAtURL:atURL toURL:toURL error:nil];
}

-(BOOL)createFileAtFileNameIfNeed:(NSString *)fileName
{
    if (!fileName) {
        return NO ;
    }
    
    NSString * path = [[QJFileManeger commonFolderPath] stringByAppendingPathComponent:fileName];
    
    if (![self folderPathIsExist:path]) {
        return [self.fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    else{
        return YES ;
    }
}

-(BOOL)removeImageWithImageName:(NSString *)imageName
{
    if (!imageName) {
        return NO ;
    }
    
    NSString * path = [self getImagePathWithImageName:imageName];
    
    if (![self fileIsExist:path]) {
        return YES ;
    }
    
   return [self.fileManager removeItemAtPath:path error:nil];
}

-(BOOL)removeFolder:(NSString *)folderName
{
    if (!folderName) {
        return NO ;
    }
    
    NSString * path = [[QJFileManeger commonFolderPath] stringByAppendingPathComponent:folderName];
    
    if (![self folderPathIsExist:path]) {
        return YES ;
    }
    
    return [self.fileManager removeItemAtPath:path error:nil];
}

-(BOOL)removeAllImageCache
{
    if (![self folderPathIsExist:[QJFileManeger commonFolderPath]]) {
        return YES ;
    }
    return [self.fileManager removeItemAtPath:[QJFileManeger commonFolderPath] error:nil];
}

-(BOOL)folderPathIsExist:(NSString *)folderPath
{
    if (!folderPath) {
        return NO ;
    }
    
    return [self.fileManager fileExistsAtPath:folderPath];
}

-(BOOL)fileIsExist:(NSString *)fileName
{
    if (!fileName) {
        return NO ;
    }
    
    NSString * path = [[self currentCacheFolder] stringByAppendingPathComponent:fileName];

    return [self.fileManager fileExistsAtPath:path];
}

-(NSInteger)fileSizeWithFilePath:(NSString *)filePath
{
    if (![self folderPathIsExist:filePath]) {
        return 0 ;
    }
    
    return [[self.fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
}

-(NSInteger)imageFileSizeWithImageName:(NSString *)imageName
{
    NSString * imagePath = [[self currentCacheFolder] stringByAppendingPathComponent:imageName];
    
    return [self fileSizeWithFilePath:imagePath];
}

-(NSString *)getImagePathWithImageName:(NSString *)imageName
{
    if (!imageName) {
        return nil ;
    }
    
    [self createFileAtFileNameIfNeed:self.rootFolderName];
    
    NSString * imagePath = [[self currentCacheFolder] stringByAppendingPathComponent:imageName] ;
    
    return imagePath;
}

-(UIImage *)getImageWithImageName:(NSString *)imageName
{
    NSString * path = [self getImagePathWithImageName:imageName];
    if (!path) {
        return nil ;
    }

    UIImage * image = [UIImage imageWithContentsOfFile:path];
    
    return image ;
}

@end
