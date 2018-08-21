//
//  XCLabelListModel.m
//  XiaoYiService
//
//  Created by 樊小聪 on 2017/5/2.
//  Copyright © 2017年 樊小聪. All rights reserved.
//


/*
 *  备注：标签 item 模型 🐾
 */


#import "XCLabelListModel.h"

@implementation XCLabelListModel

+ (instancetype)listModelWithTitle:(NSString *)title
{
    XCLabelListModel *model = [[XCLabelListModel alloc] init];
    
    model.title    = title;
    model.selected = NO;
    
    return model;
}

@end
