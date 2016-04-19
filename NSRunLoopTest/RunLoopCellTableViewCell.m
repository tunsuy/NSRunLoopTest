//
//  RunLoopCellTableViewCell.m
//  NSRunLoopTest
//
//  Created by tunsuy on 19/3/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "RunLoopCellTableViewCell.h"
#import "PicCache.h"
#import "IOSMD5.h"
#import "UIImage+CornorImage.h"
#import "UIImageView+CornorImageView.h"

#define kHeadPicLeftPadding 10
#define kHeadPicToPersonNameLeft 10
#define kPersonNameRightPadding 10
#define kHeadPicWidth 50
#define kHeadPicToContentTop 5
#define kSubViewMargin 10

#define kPersonNameLabelFontSize 14
#define kContentLabelFontSize 12

#define KCornorRadius 25

static NSString *const cacheImageDir = @"imageCache";

typedef NS_ENUM(NSInteger, ContentType){
    ContentTypeName = 0,
    ContentTypeContent = 1 << 1
};

@implementation RunLoopCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self generateContentViews];
    }
    return self;
}

- (void)generateContentViews {
//    _headPicImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kHeadPicLeftPadding, kSubViewMargin, kHeadPicWidth, kHeadPicWidth)];
//    _headPicImageView.contentMode = UIViewContentModeScaleAspectFit;
    
//    第一种：直接通过设置圆角和mask来显示圆形图
//    _headPicImageView.layer.cornerRadius = kCornorRadius;
//    _headPicImageView.clipsToBounds = YES;
//    _headPicImageView.layer.shouldRasterize = YES;
//    _headPicImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
//    第三种：通过定义uiimageview子类来显示圆形图
//    _headPicImageView = [[CornorImageView alloc] initWithFrame:CGRectMake(kHeadPicLeftPadding, kSubViewMargin, kHeadPicWidth, kHeadPicWidth)];
//    _headPicImageView.contentMode = UIViewContentModeScaleAspectFit;
//    _headPicImageView.cornorRadius = KCornorRadius;
//    [_headPicImageView addMaskToBounds:_headPicImageView.frame];
    
//    第四种：子类化UIImageView,给UIImageView上面盖一层中间镂空的遮罩(待实现)
    
//    第五种：通过定义uiimageview分类来显示圆形图
    _headPicImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kHeadPicLeftPadding, kSubViewMargin, kHeadPicWidth, kHeadPicWidth)];
    _headPicImageView.cornorRadius = KCornorRadius;
    _headPicImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _personNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kHeadPicLeftPadding+kHeadPicToPersonNameLeft+kHeadPicWidth, kSubViewMargin, [UIScreen mainScreen].bounds.size.width-kHeadPicLeftPadding-kHeadPicWidth-kHeadPicToPersonNameLeft-kPersonNameRightPadding, 0)];
    _personNameLabel.font = [UIFont systemFontOfSize:kPersonNameLabelFontSize];
    _personNameLabel.textColor = [UIColor blackColor];
    _personNameLabel.numberOfLines = 0;
//    _personNameLabel.opaque = true;
    _personNameLabel.backgroundColor = [UIColor whiteColor];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(kHeadPicLeftPadding, kSubViewMargin+kHeadPicWidth+kHeadPicToContentTop, [UIScreen mainScreen].bounds.size.width-kHeadPicLeftPadding-kPersonNameRightPadding, 0)];
    _contentLabel.font = [UIFont systemFontOfSize:kContentLabelFontSize];
    _contentLabel.textColor = [UIColor grayColor];
    _contentLabel.numberOfLines = 0;
    
    [self.contentView addSubview:_headPicImageView];
    [self.contentView addSubview:_personNameLabel];
    [self.contentView addSubview:_contentLabel];
    
}

+ (CGFloat)calurateCellHeight:(RunLoopModel *)runLoop {
    CGFloat realHeight = kSubViewMargin;
    realHeight += kHeadPicWidth > [[self class] calurateLabelTextHeight:runLoop.personName withType:ContentTypeName] ? kHeadPicWidth : [[self class] calurateLabelTextHeight:runLoop.personName withType:ContentTypeName];
    realHeight += kHeadPicToContentTop;
    realHeight += [[self class] calurateLabelTextHeight:runLoop.content withType:ContentTypeContent];
    return realHeight += kSubViewMargin;
}

+ (CGFloat)calurateLabelTextHeight:(NSString *)content withType:(ContentType)type {
//    CGSize size = [content sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kContentLabelFontSize]}];
//    return size.height;
    
    CGRect rect;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:kContentLabelFontSize]};
    
    switch (type) {
        case ContentTypeName:
            rect = [content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-kHeadPicLeftPadding-kHeadPicWidth-kHeadPicToPersonNameLeft-kPersonNameRightPadding, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
            
            break;
        case ContentTypeContent:
            rect = [content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-kHeadPicLeftPadding-kPersonNameRightPadding, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
            break;
            
        default:
            break;
    }
    return rect.size.height;
    
    
}

- (void)realLabelTextHeight {
    CGRect frame = _personNameLabel.frame;
    frame.size.height = [[self class] calurateLabelTextHeight:_personNameLabel.text withType:ContentTypeName];
    _personNameLabel.frame = frame;
    
    frame = _contentLabel.frame;
    frame.origin.y = kHeadPicWidth > _personNameLabel.frame.size.height ? kHeadPicWidth+kSubViewMargin+kHeadPicToContentTop : _personNameLabel.frame.size.height+kSubViewMargin+kHeadPicToContentTop;
    frame.size.height = [[self class] calurateLabelTextHeight:_contentLabel.text withType:ContentTypeContent];
    _contentLabel.frame = frame;
}

- (void)setRunloop:(RunLoopModel *)runloop{
    _runloop = runloop;
    
    NSString *imageUrlStr = _runloop.headPicInfo[@"imageName"];
//   第二种 ： 缓存图片到内存
//    [self memImageHandlerWithImageUrl:imageUrlStr];
    
//    第三种 ： 缓存图片到磁盘
    [self diskImageHandlerWithImageUrl:imageUrlStr];
    
//    _headPicImageView.image = [UIImage imageNamed:_runloop.headPicInfo[@"imageName"]];
    
    _personNameLabel.text = _runloop.personName;
    _contentLabel.text = _runloop.content;
    
    [self realLabelTextHeight];
}

- (NSData *)downloaderImageWithImageUrl:(NSString *)imageUrlStr {
    NSError *error;
    NSURL *imageUrl = [NSURL URLWithString:imageUrlStr];
    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl options:NSDataReadingMapped error:&error];
    return imageData;
}

- (void)memImageHandlerWithImageUrl:(NSString *)imageUrlStr {
    NSString *imageUrlMD5 = [IOSMD5 generateMD5Str:imageUrlStr];
    PicCache *picCache = [[PicCache sharePicCache] init];
    if ([picCache memCacheImageForKey:imageUrlMD5]) {
        UIImage *image = [picCache memCacheImageForKey:imageUrlMD5];
        
        //    第二种：通过UIImage分类增加一个返回圆角image的方法
//        _headPicImageView.image = [image cornorImageWithCornorRadius:KCornorRadius];
        
//        _headPicImageView.image = image;
//        [_headPicImageView addMaskToBounds:_headPicImageView.frame];
        
        [_headPicImageView performSelector:@selector(setImage:) withObject:image afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
        [_headPicImageView performSelector:@selector(addMaskToBounds:) withObject:[NSValue valueWithCGRect:_headPicImageView.frame] afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
        
    }else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSData *imageData = [self downloaderImageWithImageUrl:imageUrlStr];
            if (imageData != nil) {
                UIImage *image = [UIImage imageWithData:imageData];
                //               [_memCacheDic setObject:image forKey:imageUrlMD5];
                [picCache storeToMem:image forKey:imageUrlMD5];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
//                    _headPicImageView.image = [image cornorImageWithCornorRadius:KCornorRadius];
                    
//                    _headPicImageView.image = image;
//                    [_headPicImageView addMaskToBounds:_headPicImageView.frame];
                    
                    [_headPicImageView performSelector:@selector(setImage:) withObject:image afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
                    [_headPicImageView performSelector:@selector(addMaskToBounds:) withObject:[NSValue valueWithCGRect:_headPicImageView.frame] afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
                    
//                    if (!_memCacheDic) {
//                        _memCacheDic = [[NSMutableDictionary alloc] init];
//                    }
                });
            }
        });
    }
}

- (void)diskImageHandlerWithImageUrl:(NSString *)imageUrlStr {
    NSString *imageUrlMD5 = [IOSMD5 generateMD5Str:imageUrlStr];
    PicCache *picCache = [[PicCache sharePicCache] init];
    if ([picCache diskCacheImage:cacheImageDir ForKey:imageUrlMD5]) {
        
        UIImage *image = [picCache diskCacheImage:cacheImageDir ForKey:imageUrlMD5];
        
//        _headPicImageView.image = [image cornorImageWithCornorRadius:KCornorRadius];
        
//        _headPicImageView.image = image;
//        [_headPicImageView addMaskToBounds:_headPicImageView.frame];
        
//        一种新思路：在tableview没有滚动的时候设置图片
//        注：会导致设置圆角失效
//        解决办法：将addMaskToBounds这个方法也设置成在停止滑动的时候执行
        [_headPicImageView performSelector:@selector(setImage:) withObject:image afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
        [_headPicImageView performSelector:@selector(addMaskToBounds:) withObject:[NSValue valueWithCGRect:_headPicImageView.frame] afterDelay:0 inModes:@[NSDefaultRunLoopMode]];

        
    }else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSData *imageData = [self downloaderImageWithImageUrl:imageUrlStr];
            if (imageData != nil) {
                UIImage *image = [UIImage imageWithData:imageData];
                [picCache storeToDisk:imageData withFileDir:cacheImageDir forKey:imageUrlMD5];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
//                    _headPicImageView.image = [image cornorImageWithCornorRadius:KCornorRadius];
                    
//                    _headPicImageView.image = image;
//                    [_headPicImageView addMaskToBounds:_headPicImageView.frame];
                    
                    [_headPicImageView performSelector:@selector(setImage:) withObject:image afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
                    [_headPicImageView performSelector:@selector(addMaskToBounds:) withObject:[NSValue valueWithCGRect:_headPicImageView.frame] afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
                    
                });
            }
        });
    }

}

@end
