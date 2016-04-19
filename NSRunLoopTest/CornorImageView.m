//
//  CornorImageView.m
//  NSRunLoopTest
//
//  Created by tunsuy on 23/3/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "CornorImageView.h"

#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

@implementation CornorImageView

- (void)addMaskToBounds:(id)objMaskBounds {
    CGRect maskBounds = [objMaskBounds CGRectValue];
    
    CGFloat w = maskBounds.size.width;
    CGFloat h = maskBounds.size.height;
    
    if (_cornorRadius < 0) {
        _cornorRadius = 0;
    }else if (_cornorRadius > MIN(w, h)) {
        _cornorRadius = MIN(w, h);
    }
    
    CGSize size = maskBounds.size;
//    像素偏移
    CGRect imageFrame = CGRectMake(SINGLE_LINE_ADJUST_OFFSET, 0, w-SINGLE_LINE_ADJUST_OFFSET, h);
    
    UIImage *image = self.image;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:imageFrame cornerRadius:_cornorRadius] addClip];
    [image drawInRect:imageFrame];
    
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
}

@end
