//
//  UIImage+CornorImage.m
//  NSRunLoopTest
//
//  Created by tunsuy on 23/3/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "UIImage+CornorImage.h"

@implementation UIImage (CornorImage)

- (UIImage *)cornorImageWithCornorRadius:(CGFloat)cornorRadius {
    CGFloat w = self.size.width;
    CGFloat h = self.size.height;
    
    if (cornorRadius < 0) {
        cornorRadius = 0;
    }else if (cornorRadius > MIN(w, h)) {
        cornorRadius = MIN(w, h)/2;
    }
    
    CGRect imageFrame = CGRectMake(0, 0, w, h);
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:imageFrame cornerRadius:cornorRadius] addClip];
    [self drawInRect:imageFrame];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

@end
