//
//  PicCache.m
//  NSRunLoopTest
//
//  Created by tunsuy on 21/3/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "PicCache.h"

@interface PicCache()

@property (nonatomic, strong) NSMutableDictionary *memCacheDic;

@end

@implementation PicCache

+ (PicCache *)sharePicCache {
    static dispatch_once_t oneToken;
    static PicCache *picCache;
    dispatch_once(&oneToken, ^{
        picCache = [[PicCache alloc] init];
    });
    return picCache;
}

- (instancetype)init {
    if (self = [super init]) {
        if (!_memCacheDic) {
            _memCacheDic = [[NSMutableDictionary alloc] init];
        }
    }
    return self;
}

- (NSString *)filePathAtDiskCacheDir:(NSString *)fileDir forFileName:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSLog(@"paths are : %@", paths);
    NSString *diskCacheDir  = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileDir];
    NSLog(@"diskCachePath is : %@", diskCacheDir);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:diskCacheDir]) {
        NSError *error;
        @try {
            [[NSFileManager defaultManager] createDirectoryAtPath:diskCacheDir withIntermediateDirectories:YES attributes:nil error:&error];
        }
        @catch (NSException *exception) {
            NSLog(@"create file is failed !  reason : %@", exception);
        }
        @finally {
            
        }
    }
    
    return fileName ? [diskCacheDir stringByAppendingPathComponent:fileName] : diskCacheDir;
}


- (UIImage *)memCacheImageForKey:(NSString *)fileKey {
    if (!fileKey) {
        return nil;
    }
    return _memCacheDic[fileKey];
}

- (void)storeToMem:(UIImage *)image forKey:(NSString *)key {
    if (image && key) {
        [_memCacheDic setObject:image forKey:key];
    }
}

- (UIImage *)diskCacheImage:(NSString *)fileDir ForKey:(NSString *)fileKey {
    if (!fileKey) {
        return nil;
    }
    NSString *filePath = [self filePathAtDiskCacheDir:fileDir forFileName:fileKey];
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:imageData];
    return image;
}

- (void)storeToDisk:(NSData *)imageData withFileDir:(NSString *)fileDir forKey:(NSString *)key {
    NSString *filePath = [self filePathAtDiskCacheDir:fileDir forFileName:key];
    NSLog(@"filePath is : %@", filePath);
    if (imageData && key) {
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:imageData attributes:nil];
    }
}

- (void)clearMemoryWithCallback:(TSCallback)callback {
    @try {
        [_memCacheDic removeAllObjects];
        callback(nil);
    }
    @catch (NSException *exception) {
        NSError *error = [[NSError alloc] initWithDomain:@"picCacheErrorDomain" code:1 userInfo:@{@"reason":exception}];
        callback(error);
    }
    @finally {
        callback(nil);
    }
    
}

- (void)clearAllDiskCacheForFileDir:(NSString *)fileDir withCallback:(TSCallback)callback {
    if (fileDir) {
        NSString *fileDirPath = [self filePathAtDiskCacheDir:fileDir forFileName:nil];
        [[NSFileManager defaultManager] removeItemAtPath:fileDirPath error:NULL];
        callback(nil);
        return;
    }
    NSError *error = [[NSError alloc] initWithDomain:@"picCacheErrorDomain" code:1 userInfo:@{@"reason":@"清除缓存失败"}];
    callback(error);
}

@end
