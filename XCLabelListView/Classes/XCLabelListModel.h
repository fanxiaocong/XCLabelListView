//
//  XCLabelListModel.h
//  XiaoYiService
//
//  Created by 樊小聪 on 2017/5/2.
//  Copyright © 2017年 樊小聪. All rights reserved.
//


/*
 *  备注：标签 item 模型 🐾
 */

#import <Foundation/Foundation.h>

@interface XCLabelListModel : NSObject

/** 👀 标题 👀 */
@property (copy, nonatomic) NSString *title;

/** 👀 标题文字的宽度 👀 */
@property (assign, nonatomic) CGFloat titleWidth;

/** 👀 是否选中 👀 */
@property (assign, nonatomic, getter=isSelected) BOOL selected;

+ (instancetype)listModelWithTitle:(NSString *)title;

@end
