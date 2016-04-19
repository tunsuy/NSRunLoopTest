//
//  UIImageView+CornorImageView.m
//  NSRunLoopTest
//
//  Created by tunsuy on 23/3/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "UIImageView+CornorImageView.h"
#import <objc/runtime.h>

static char cornorRadiusKey;

@implementation UIImageView (CornorImageView)

- (void)setCornorRadius:(CGFloat)cornorRadius {
    
//    注：OBJC_ASSOCIATION_RETAIN_NONATOMIC这里写成assigned会有问题
    objc_setAssociatedObject(self, &cornorRadiusKey, @(cornorRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)cornorRadius {
//    NSLog(@"cornorRadius : %@", @selector(cornorRadius));
     return [objc_getAssociatedObject(self, &cornorRadiusKey) floatValue];
}

- (void)addMaskToBounds:(id)objMaskBounds {
    CGRect maskBounds = [objMaskBounds CGRectValue];
    
    CGFloat w = maskBounds.size.width;
    CGFloat h = maskBounds.size.height;
    
    if (self.cornorRadius < 0) {
        self.cornorRadius = 0;
    }else if (self.cornorRadius > MIN(w, h)) {
        self.cornorRadius = MIN(w, h);
    }
    
    CGSize size = maskBounds.size;
    //    像素偏移
    CGRect imageFrame = CGRectMake(0, 0, w, h);
    
    UIImage *image = self.image;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:imageFrame cornerRadius:self.cornorRadius] addClip];
    [image drawInRect:imageFrame];
    
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
}

@end
