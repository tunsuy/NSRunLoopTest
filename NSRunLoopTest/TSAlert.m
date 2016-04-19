//
//  TSAlert.m
//  NSRunLoopTest
//
//  Created by tunsuy on 22/3/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "TSAlert.h"

#define kBackViewWidth 150
#define kActivityIndicatorViewWidth 30
#define kActivityIndicatorViewAnchorY 40
#define kTipAnchorY 70

#define kTitleFontSize 14

#define kTipPadding 10

@interface TSAlert()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation TSAlert

- (instancetype)initWithTitle:(NSString *)alertTitle andAlertType:(TSAlertType)alertType {
    self = [self initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.alpha = 0.7;
        [self generateContentViewsWithAlertTitle:alertTitle];
        [self layoutContentViewsWithAlertTitle:alertTitle ForAlertType:alertType];
    }
    return self;
}

- (instancetype)initWithTitleOnly:(NSString *)alertTitle {
    if (self = [self initWithTitle:alertTitle andAlertType:TSAlertTypeNone]) {
        
    }
    return self;
}

- (instancetype)initWithLoadingOnly {
    if (self = [self initWithTitle:@"" andAlertType:TSAlertTypeLoading]) {
      
    }
    return self;
}

- (void)generateContentViewsWithAlertTitle:(NSString *)alertTitle {
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kBackViewWidth, kBackViewWidth)];
    _backView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    _backView.backgroundColor = [UIColor grayColor];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, kActivityIndicatorViewWidth, kActivityIndicatorViewWidth)];
    _activityIndicatorView.center = CGPointMake(_backView.frame.size.width/2, kActivityIndicatorViewAnchorY);
    _activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    CGSize size = [alertTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kTitleFontSize]}];
    CGFloat tipWidth = MIN(size.width, kBackViewWidth - kTipPadding*2);
    _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tipWidth, size.height)];
    _tipLabel.center = CGPointMake(_backView.frame.size.width/2, kTipAnchorY);
    _tipLabel.text = alertTitle;
    _tipLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
    _tipLabel.textColor = [UIColor blueColor];
}

- (void)layoutContentViewsWithAlertTitle:(NSString *)alertTitle ForAlertType:(TSAlertType)alertType {
    
    switch (alertType) {
        case TSAlertTypeNone:
        case TSAlertTypeLoadingSuccess:
        case TSAlertTypeLoadingFailed:
            _tipLabel.center = CGPointMake(_backView.frame.size.width/2, _backView.frame.size.height/2);
            _tipLabel.text = alertTitle;
            [_backView addSubview:_tipLabel];
            break;
        case TSAlertTypeLoading:
            _activityIndicatorView.center = CGPointMake(_backView.frame.size.width/2, _backView.frame.size.height/2);;
            [_backView addSubview:_activityIndicatorView];
            break;
        case TSAlertTypeTipLoading:
            [_backView addSubview:_tipLabel];
            [_backView addSubview:_activityIndicatorView];
            break;
            
        default:
            break;
    }
    
    [self addSubview:_backView];
    
}

- (void)show {
    [_activityIndicatorView startAnimating];
}

- (void)dismissAlertView {
    [self removeFromSuperview];
}

- (void)removeAllSubViews {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

- (void)loadingSuccessWithAlertTitle:(NSString *)alertTitle forAlertType:(TSAlertType)alertType {
    [_backView removeFromSuperview];
    [self generateContentViewsWithAlertTitle:alertTitle];
    [self layoutContentViewsWithAlertTitle:alertTitle ForAlertType:alertType];
}

- (void)loadingFailedWithAlertTitle:(NSString *)alertTitle forAlertType:(TSAlertType)alertType {
    [_backView removeFromSuperview];
    [self generateContentViewsWithAlertTitle:alertTitle];
    [self layoutContentViewsWithAlertTitle:alertTitle ForAlertType:alertType];
}

@end
