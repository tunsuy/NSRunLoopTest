//
//  RunLoopCellTableViewCell.h
//  NSRunLoopTest
//
//  Created by tunsuy on 19/3/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunLoopModel.h"
#import "CornorImageView.h"

//@class RunLoopModel;

@interface RunLoopCellTableViewCell : UITableViewCell

//@property (nonatomic, strong) UIImageView *headPicImageView;
@property (nonatomic, strong) UILabel *personNameLabel;
@property (nonatomic, strong) UILabel *contentLabel;

//@property (nonatomic, strong) CornorImageView *headPicImageView;

@property (nonatomic, strong) UIImageView *headPicImageView;

@property (nonatomic, strong) RunLoopModel *runloop;
//@property (nonatomic, strong) NSMutableDictionary *memCacheDic;

+ (CGFloat)calurateCellHeight:(RunLoopModel *)runLoop;

@end
