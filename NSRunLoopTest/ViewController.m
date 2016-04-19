//
//  ViewController.m
//  NSRunLoopTest
//
//  Created by tunsuy on 19/3/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "ViewController.h"
#import "RunLoopCellTableViewCell.h"
#import "RunLoopModel.h"
#import "SettingViewController.h"

#define kCellNumbers 500

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *runLoopArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"setting", nil) style:UIBarButtonItemStylePlain target:self action:@selector(settingClick:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    
    [self initData];
    
}

- (void)initData {
//    NSArray *imageNameArr = @[@"IMG1.jpg", @"IMG2.jpg", @"IMG3.png", @"IMG4.jpg", @"IMG5.jpg"];
    NSArray *imageNameArr = @[@"https://dn-kdoss.qbox.me/Fo-ZULwcmQeXvRkcDYW9VbKmV2qD?imageView2/1/w/80/h/80&e=1458726147&token=BDlsCI9C9xGl-aBysVoFl7-eu9c2j5JLredsogNl:2Seu1LHIaEhamDdEEL1fTXxI8sU=",
                              @"https://dn-kdoss.qbox.me/Fq8ab3Dtpy-RT2LVm9gxL4Oki6aE?imageView2/1/w/80/h/80&e=1458726147&token=BDlsCI9C9xGl-aBysVoFl7-eu9c2j5JLredsogNl:DsDDp8AHV6MWKxFf_0PAwx0looE=",
                              @"https://dn-kdoss.qbox.me/Fiw3DSXry4vgrmJD9FHafD6W-xqn?imageView2/1/w/80/h/80&e=1458726147&token=BDlsCI9C9xGl-aBysVoFl7-eu9c2j5JLredsogNl:rkU8WBHfGOLjauLlSUms-atxO0A=",
                              @"https://dn-kdoss.qbox.me/FvXWosCYx63hUQvFSF7F6UT4s-9C?imageView2/1/w/80/h/80&e=1458726147&token=BDlsCI9C9xGl-aBysVoFl7-eu9c2j5JLredsogNl:12sOJjXpfd_k2Pux7mDm6SfSq7E=",
                              @"https://dn-kdoss.qbox.me/Fh8oesyY0vINSdC7FHMCZuXIJB0H?imageView2/1/w/80/h/80&e=1458726147&token=BDlsCI9C9xGl-aBysVoFl7-eu9c2j5JLredsogNl:YByM0xl0K5wTyiK-m2Y7qJMzrLk="];
    NSArray *personNameArr = @[@"时间是高考结束了电饭锅飞撒的发撒", @"是根据实际收款的贷款郭德纲", @"三国杀两个的法律规定过", @"估计快累死了大范甘迪", @"的规定了更健康"];
    NSArray *contentArr = @[@"是国家开始了是雷锋精神的分离式建立国家大概觉得浪费国家大概的结果大家法国就的房间管理的的房间管理的结果奋斗经历",
                            @"数据库决定了国家的法规剪短发了国家的觉得发个链接的建立国家的家里的感觉的决定了国家的建立覆盖大概几点了耳兔额人",
                            @"对甲方根据地方尔特人而提供的风格大范甘迪的共和党高大上反对法国多个电饭锅电饭锅的非官方大哥尔特人活动符合规定发",
                            @"设计方老师打了几个地方的房间管理的法规的经费管理的瑞特让他尔特人大范甘迪尔特人热帖华国锋犹太人同意我惹我我惹我",
                            @"啥地方就是该罚的罚而特大范甘迪沃尔沃人撒的发撒沃尔沃沃尔沃撒的发撒大范甘迪连接破分隔符泛光灯玩儿发郭德纲电饭锅"];
    _runLoopArr = [[NSMutableArray alloc] initWithCapacity:kCellNumbers];
    NSInteger index;
    NSMutableDictionary *headPicInfo;
    for (int i=0; i<kCellNumbers; i++) {
        index = arc4random()%5;
//        [_imagesArr addObject:imageNameArr[imageIndex]];
        headPicInfo = [[NSMutableDictionary alloc] init];
        headPicInfo[@"imageName"] = imageNameArr[index];
        RunLoopModel *runLoop = [[RunLoopModel alloc] init];
        runLoop.headPicInfo = headPicInfo;
        runLoop.personName = personNameArr[index];
        runLoop.content = contentArr[index];
        [_runLoopArr addObject:runLoop];
    }
    
}

- (void)settingClick:(id)sender {
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _runLoopArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellid";
    RunLoopCellTableViewCell *cell = (RunLoopCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[RunLoopCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
//    第一种 ： 清除图片避免跳动
//    cell.headPicImageView.image = nil;
    cell.runloop = _runLoopArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RunLoopModel *runLoop = _runLoopArr[indexPath.row];
    
    return [RunLoopCellTableViewCell calurateCellHeight:runLoop];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if ([scrollView isKindOfClass:[UITableView class]]) {
//        <#statements#>
//    }
//}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"我可以查看的";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
