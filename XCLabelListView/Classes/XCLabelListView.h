//
//  XCLabelListView.h
//  XiaoYiService
//
//  Created by 樊小聪 on 2017/5/2.
//  Copyright © 2017年 樊小聪. All rights reserved.
//


/*
 *  备注：自定义标签列表视图 🐾
 */


#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface XCLabelListView : UIView

/** 👀 是否允许多选：默认：NO 👀 */
@property (assign, nonatomic) IBInspectable BOOL allowsMultipleSelection;

/** 👀 是否允许滚动：默认 NO 👀 */
@property (assign, nonatomic) IBInspectable BOOL scrollEnabled;
/** 👀 行间距 👀 */
@property (assign, nonatomic) IBInspectable CGFloat rowMargin;
/** 👀 列表间距 👀 */
@property (assign, nonatomic) IBInspectable CGFloat columnsMargin;
/** 👀 行高：默认 30 👀 */
@property (assign, nonatomic) IBInspectable CGFloat rowHeight;
/** 👀 圆角半径：默认为 rowHeight * 0.5 👀 */
@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;
/** 👀 内容的偏移量（默认 15） 👀 */
@property (assign, nonatomic) IBInspectable UIEdgeInsets contentInsets;
/** 👀 每个 item 中文字与边界的距离(X轴方向上，默认 15) 👀 */
@property (assign, nonatomic) IBInspectable CGFloat itemInsetsX;
/** 👀 正常状态下的文字颜色 👀 */
@property (strong, nonatomic) IBInspectable UIColor *normalTitleColor;
/** 👀 选中状态下的文字颜色 👀 */
@property (strong, nonatomic) IBInspectable UIColor *selectedTitleColor;
/** 👀 正常状态下的背景颜色 👀 */
@property (strong, nonatomic) IBInspectable UIColor *normalBackgroundColor;
/** 👀 选中状态下的背景颜色 👀 */
@property (strong, nonatomic) IBInspectable UIColor *selectedBackgroundColor;

/** 👀 标题大小：默认 13号字体 👀 */
@property (assign, nonatomic)IBInspectable CGFloat titleFontSize;




/** 👀 数据源：当给其赋值后，控件内部实现UI刷新功能 👀 */
@property (strong, nonatomic) NSArray<NSString *> *dataSource;

/** 👀 已经选择好的下标数组 👀 */
@property (strong, nonatomic, readonly) NSArray<NSNumber *> *selectedIndexs;

/** 👀 当获取到内容的高度的时候的回调：此时可以拿到视图的准确高度 👀 */
@property (copy, nonatomic) void(^didFetchContentHeightCallBack)(XCLabelListView *listView, CGFloat contentH);

/** 👀 当选中某个下标的回调 👀 */
@property (copy, nonatomic) void(^didClickItemCallBack)(XCLabelListView *listView, NSInteger idnex);


@end
