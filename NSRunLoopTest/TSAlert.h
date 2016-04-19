//
//  TSAlert.h
//  NSRunLoopTest
//
//  Created by tunsuy on 22/3/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TSAlertType) {
    TSAlertTypeNone = 0,
    TSAlertTypeLoading,
    TSAlertTypeTipLoading,
    TSAlertTypeLoadingSuccess,
    TSAlertTypeLoadingFailed
};

@interface TSAlert : UIView

- (instancetype)initWithTitle:(NSString *)alertTitle andAlertType:(TSAlertType)alertType;
- (instancetype)initWithTitleOnly:(NSString *)alertTitle;
- (instancetype)initWithLoadingOnly;

- (void)show;
- (void)dismissAlertView;
- (void)loadingSuccessWithAlertTitle:(NSString *)alertTitle forAlertType:(TSAlertType)alertType;
- (void)loadingFailedWithAlertTitle:(NSString *)alertTitle forAlertType:(TSAlertType)alertType;

@end
