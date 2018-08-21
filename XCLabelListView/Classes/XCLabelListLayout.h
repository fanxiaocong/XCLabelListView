//
//  XCLabelListLayout.h
//  XiaoYiService
//
//  Created by 樊小聪 on 2017/5/2.
//  Copyright © 2017年 樊小聪. All rights reserved.
//


/*
 *  备注：自定义标签列表布局 🐾
 */


#import <UIKit/UIKit.h>

@class XCLabelListLayout;


@protocol XCLabelListLayoutDelegate <NSObject>

/**
 *  返回每个 item 的尺寸大小
 *
 *  @param layout       布局
 *  @param indexPath    每对 item 的索引
 */
- (CGSize)labelListLayout:(XCLabelListLayout *)layout
   sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  当布局完成后的回调
 */
- (void)layoutDidFinish:(XCLabelListLayout *)layout;

@end


@interface XCLabelListLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) CGFloat contentHeight;

/** 每列之间的间距 */
@property (nonatomic, assign) CGFloat columnsMargin;

/** 每行之间的间距 */
@property (nonatomic, assign) CGFloat rowMargin;

@property (nonatomic, weak) id<XCLabelListLayoutDelegate> delegate;

@end
