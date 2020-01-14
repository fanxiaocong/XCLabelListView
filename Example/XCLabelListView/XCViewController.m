//
//  XCViewController.m
//  XCLabelListView
//
//  Created by fanxiaocong on 08/21/2018.
//  Copyright (c) 2018 fanxiaocong. All rights reserved.
//

#import "XCViewController.h"
#import <XCLabelListView/XCLabelListView.h>

@interface XCViewController ()

@property (weak, nonatomic) XCLabelListView *listView;

@end

@implementation XCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /// 设置 UI
    [self setupUI];
}

#pragma mark - ✏️ 🖼 SetupUI Method 🖼

- (void)setupUI
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;

    XCLabelListView *listView = [[XCLabelListView alloc] initWithFrame:CGRectMake(50, 100, width-100, 100)];
    self.listView = listView;
    self.listView.cornerRadius = 20;
    self.listView.rowHeight = 40;
    self.listView.titleFontSize = 15;
    self.listView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:.3f];
    self.listView.normalTitleColor = [UIColor whiteColor];
    self.listView.normalBackgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.3f];
    self.listView.selectedBackgroundColor = [[UIColor redColor] colorWithAlphaComponent:.7f];
    self.listView.allowsMultipleSelection = YES;
    self.listView.dataSource = @[@"天气", @"晚餐", @"iPhone X",
                                @"苹果手机", @"今天天气真是好", @"牛",
                                 @"华为", @"三星", @"小米", @"变形金刚"];
    
    // 选中某个 类型 的回调
    self.listView.didClickItemCallBack = ^(XCLabelListView *listView, NSInteger index) {
        NSLog(@"当前点击的是第 %zi 个元素", index);
        NSLog(@"总共已选中的元素：%@", listView.selectedIndexs);
    };
    
    /// 获取 listView 的实际高度
    self.listView.didFetchContentHeightCallBack = ^(XCLabelListView *l, CGFloat contentH) {
        NSLog(@"最终高度：%f", contentH);
    };
    [self.view addSubview:listView];
}

@end
