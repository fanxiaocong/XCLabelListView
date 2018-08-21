//
//  XCLabelListView.m
//  XiaoYiService
//
//  Created by 樊小聪 on 2017/5/2.
//  Copyright © 2017年 樊小聪. All rights reserved.
//


/*
 *  备注：自定义标签列表视图 🐾
 */


#import "XCLabelListView.h"
#import "XCLabelListLayout.h"
#import "XCLabelListCell.h"
#import "XCLabelListModel.h"


#define NORMAL_TITLE_COLOR          [UIColor darkGrayColor]
#define SELECTED_TITLE_COLOR        [UIColor whiteColor]
#define NORMAL_BACKGROUND_COLOR     [UIColor lightGrayColor]
#define SELECTED_BACKGROUND_COLOR   [UIColor orangeColor]


@interface XCLabelListView ()<UICollectionViewDelegate, UICollectionViewDataSource, XCLabelListLayoutDelegate>

@property (weak, nonatomic) UICollectionView *collectView;

@property (strong, nonatomic) XCLabelListLayout *layout;

@property (assign, nonatomic) CGFloat contentH;

/** 👀 每个 item 的模型数组 👀 */
@property (strong, nonatomic) NSArray<XCLabelListModel *> *models;

/** 👀 是否加载完毕 👀 */
@property (assign, nonatomic) BOOL loadFinished;

@end

static NSString * const cellIdentifier = @"XCLabelListCell";

@implementation XCLabelListView

#pragma mark - 👀 Init Method 👀 💤

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        // 设置默认参数
        [self setupDefaults];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // 设置默认参数
        [self setupDefaults];
    }
    
    return self;
}

// 设置默认参数
- (void)setupDefaults
{
    // 设置 collectionView 的布局属性
    XCLabelListLayout *layout = [[XCLabelListLayout alloc] init];
    layout.delegate = self;
    self.layout = layout;
    
    self.allowsMultipleSelection = NO;
    self.rowMargin      = 15;
    self.columnsMargin  = 15;
    self.rowHeight      = 30;
    self.contentInsetsX = 15;
    self.cornerRadius   = self.rowHeight * 0.5;
    self.titleFontSize  = 13;
    
    self.normalTitleColor   = NORMAL_TITLE_COLOR;
    self.selectedTitleColor = SELECTED_TITLE_COLOR;
    
    self.normalBackgroundColor   = NORMAL_BACKGROUND_COLOR;
    self.selectedBackgroundColor = SELECTED_BACKGROUND_COLOR;
    
    // 设置 collectionView
    UICollectionView *collectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    collectView.backgroundColor = [UIColor clearColor];
    collectView.dataSource = self;
    collectView.delegate   = self;
    collectView.alwaysBounceVertical = YES;
    collectView.showsHorizontalScrollIndicator = NO;
    collectView.scrollEnabled = NO;
    
    [self addSubview:collectView];
    
    self.collectView = collectView;
    
    [self.collectView registerNib:[UINib nibWithNibName:cellIdentifier bundle:[NSBundle bundleForClass:[self class]]] forCellWithReuseIdentifier:cellIdentifier];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectView.frame = self.bounds;
}

#pragma mark - 👀 Setter Method 👀 💤

- (void)setAllowsMultipleSelection:(BOOL)allowsMultipleSelection
{
    _allowsMultipleSelection = allowsMultipleSelection;
    
    self.collectView.allowsMultipleSelection = allowsMultipleSelection;
}

- (void)setRowMargin:(CGFloat)rowMargin
{
    _rowMargin = rowMargin;
    
    self.layout.rowMargin = rowMargin;
}

- (void)setColumnsMargin:(CGFloat)columnsMargin
{
    _columnsMargin = columnsMargin;
    
    self.layout.columnsMargin = columnsMargin;
}

- (void)setContentInsetsX:(CGFloat)contentInsetsX
{
    _contentInsetsX = contentInsetsX;
    
    self.layout.sectionInset = UIEdgeInsetsMake(0, contentInsetsX, 0, contentInsetsX);
}

- (void)setDataArray:(NSArray<NSString *> *)dataArray
{
    _dataArray = dataArray;
    
    NSMutableArray *mArr = [NSMutableArray array];
    
    for (NSString *title in dataArray)
    {
        XCLabelListModel *model = [XCLabelListModel listModelWithTitle:title];
        
        model.titleWidth = [title sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:self.titleFontSize]}].width;
        
        [mArr addObject:model];
    }
    
    self.loadFinished = NO;
    self.models = mArr;
    
    [self.collectView reloadData];
}

#pragma mark - 📕 👀 UICollectionViewDataSource 👀

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XCLabelListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (indexPath.item < self.models.count)
    {
        XCLabelListModel *model = self.models[indexPath.item];
        
        cell.titleLB.text = model.title;
        
        cell.titleLB.textAlignment = NSTextAlignmentCenter;
        cell.titleLB.layer.cornerRadius = self.cornerRadius;
        cell.titleLB.layer.masksToBounds = YES;
        cell.titleLB.font = [UIFont systemFontOfSize:self.titleFontSize];
        
        if (model.isSelected)
        {
            cell.titleLB.textColor = self.selectedTitleColor;
            cell.titleLB.backgroundColor = self.selectedBackgroundColor;
        }
        else
        {
            cell.titleLB.textColor = self.normalTitleColor;
            cell.titleLB.backgroundColor = self.normalBackgroundColor;
        }
    }
    
    return cell;
}

#pragma mark - 💉 👀 UICollectionViewDelegate 👀

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   if (self.models.count > indexPath.item)
   {
       XCLabelListModel *model = self.models[indexPath.item];
       
       if (self.allowsMultipleSelection)
       {
           /// 多选
           model.selected = !model.isSelected;
       }
       else
       {
           /// 单选
           [self.models enumerateObjectsUsingBlock:^(XCLabelListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               
               obj.selected = (obj == model);
           }];
       }
   }

    /// 更新已经选中的数组
    NSMutableArray *mArr = [NSMutableArray array];
    
    [self.models enumerateObjectsUsingBlock:^(XCLabelListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.isSelected)
        {
            [mArr addObject:@(idx)];
        }
    }];
    
    _selectedIndexs = mArr;
    
    /// 选中的回调
    if (self.didSelectItemBlock)
    {
        self.didSelectItemBlock(self, indexPath.row);
    }
    
    [collectionView reloadData];
}


#pragma mark - 💉 👀 XCLabelListLayoutDelegate 👀

- (CGSize)labelListLayout:(XCLabelListLayout *)layout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{    
    if (self.dataArray.count > indexPath.item)
    {
        XCLabelListModel *model = self.models[indexPath.item];
        
        CGFloat width = model.titleWidth + self.contentInsetsX * 2;
                
        return CGSizeMake(width, self.rowHeight);
    }
    
    return CGSizeMake(60, self.rowHeight);
}

/**
 *  当视图的布局已经完成后的回调，这里可以获取到 layout 最终的尺寸
 */
- (void)layoutDidFinish:(XCLabelListLayout *)layout
{
    if (self.loadFinished)  return;
    
    self.loadFinished = YES;
    
    _contentH = layout.contentHeight;
    
    if (self.didFetchContentHeightBlock)
    {
        self.didFetchContentHeightBlock(self, _contentH);
    }
}

@end
