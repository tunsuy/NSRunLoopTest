//
//  SettingViewController.m
//  NSRunLoopTest
//
//  Created by tunsuy on 22/3/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "SettingViewController.h"
#import "TSAlert.h"
#import "PicCache.h"

@interface SettingViewController ()

@property (nonatomic, strong) UIButton *clearMemoryBtn;
@property (nonatomic, strong) UIButton *clearDiskBtn;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self generateContentViews];
    
}

- (void)generateContentViews {
    _clearDiskBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 150, 30)];
    [_clearDiskBtn setTitle:NSLocalizedString(@"clearDiskCache", nil) forState:UIControlStateNormal];
    [_clearDiskBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_clearDiskBtn setBackgroundColor:[UIColor orangeColor]];
    [_clearDiskBtn addTarget:self action:@selector(clearDiskCache:) forControlEvents:UIControlEventTouchUpInside];
    
    _clearMemoryBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 150, 30)];
    [_clearMemoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_clearMemoryBtn setTitle:NSLocalizedString(@"clearMemCache", nil) forState:UIControlStateNormal];
    [_clearMemoryBtn setBackgroundColor:[UIColor orangeColor]];
    [_clearMemoryBtn addTarget:self action:@selector(clearMemCache:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_clearDiskBtn];
    [self.view addSubview:_clearMemoryBtn];
}

- (void)clearMemCache:(id)sender {
    
    PicCache *picCache = [[PicCache alloc] init];
    [picCache clearMemoryWithCallback:^(id result){
        [self alertHandlerWithResult:result];
    }];
}

- (void)clearDiskCache:(id)sender {
    PicCache *picCache = [[PicCache alloc] init];
    [picCache clearAllDiskCacheForFileDir:@"imageCache" withCallback:^(id result){
        [self alertHandlerWithResult:result];
    }];
}

- (void)alertHandlerWithResult:(id)result {
    TSAlert *tsAlert = [[TSAlert alloc] initWithTitle:NSLocalizedString(@"clearing", nil) andAlertType:TSAlertTypeTipLoading];
    [self.view addSubview:tsAlert];
    [tsAlert show];
    
    dispatch_time_t showDelayTime = dispatch_time(DISPATCH_TIME_NOW, 3*NSEC_PER_SEC);
    dispatch_time_t DismissDelayTime = dispatch_time(DISPATCH_TIME_NOW, 5*NSEC_PER_SEC);
    dispatch_after(showDelayTime, dispatch_get_main_queue(), ^{
        if ([result isKindOfClass:[NSError class]]) {
            [tsAlert loadingFailedWithAlertTitle:@"清除缓存失败" forAlertType:TSAlertTypeLoadingFailed];
        }else {
            [tsAlert loadingSuccessWithAlertTitle:@"清除缓存成功" forAlertType:TSAlertTypeLoadingSuccess];
        }
        dispatch_after(DismissDelayTime, dispatch_get_main_queue(), ^{
            [tsAlert dismissAlertView];
        });
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
