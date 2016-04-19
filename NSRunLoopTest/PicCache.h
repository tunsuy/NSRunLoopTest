//
//  PicCache.h
//  NSRunLoopTest
//
//  Created by tunsuy on 21/3/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^TSCallback)(id result);

@interface PicCache : NSObject<NSFileManagerDelegate>

+ (PicCache *)sharePicCache;
- (instancetype)init;

- (UIImage *)memCacheImageForKey:(NSString *)fileKey;
- (void)storeToMem:(UIImage *)image forKey:(NSString *)key;

- (UIImage *)diskCacheImage:(NSString *)fileDir ForKey:(NSString *)fileKey;
- (void)storeToDisk:(NSData *)imageData withFileDir:(NSString *)fileDir forKey:(NSString *)key;

- (void)clearMemoryWithCallback:(TSCallback)callback;
- (void)clearAllDiskCacheForFileDir:(NSString *)fileDir withCallback:(TSCallback)callback;

@end
