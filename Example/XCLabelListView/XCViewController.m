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
{
    CGFloat _listH;
}

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

    XCLabelListView *listView = [[XCLabelListView alloc] initWithFrame:CGRectMake(50, 100, width-100, 300)];
    self.listView = listView;
    self.listView.cornerRadius = 20;
    self.listView.rowHeight = 40;
    self.listView.titleFontSize = 15;
    self.listView.backgroundColor = [UIColor blueColor];
    self.listView.selectedBackgroundColor = [UIColor redColor];
    self.listView.allowsMultipleSelection = YES;
    self.listView.dataArray = @[@"天气", @"晚餐", @"iPhone X",
                                @"苹果手机", @"今天天气真是好", @"牛"];
    
    // 选中某个 类型 的回调
    self.listView.didSelectItemBlock = ^(XCLabelListView *listView, NSInteger idnex) {
        
    };
    
    self.listView.didFetchContentHeightBlock = ^(XCLabelListView *listView, CGFloat contentH) {
        listView.frame = CGRectMake(50, 100, width-100, contentH);
    };
    [self.view addSubview:listView];
}

@end
