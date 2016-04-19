//
//  CornorImageView.h
//  NSRunLoopTest
//
//  Created by tunsuy on 23/3/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CornorImageView : UIImageView

@property (nonatomic) CGFloat cornorRadius;

//这里之所以将参数定义为id型，只是为了配合测试下RunLoopModel
//注：[_headPicImageView performSelector:@selector(addMaskToBounds:) withObject:[NSValue valueWithCGRect:_headPicImageView.frame] afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
- (void)addMaskToBounds:(id)objMaskBounds;

@end
