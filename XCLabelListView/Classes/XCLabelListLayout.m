//
//  XCLabelListLayout.m
//  XiaoYiService
//
//  Created by 樊小聪 on 2017/5/2.
//  Copyright © 2017年 樊小聪. All rights reserved.
//

/*
 *  备注：自定义标签列表布局 🐾
 */


#import "XCLabelListLayout.h"


@interface XCLabelListLayout ()

@property (nonatomic, strong) NSMutableArray *itemAttributes;

@end


@implementation XCLabelListLayout

- (id)init
{
    self = [super init];
    
    if (self) {
        [self setupDefaults];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setupDefaults];
    }
    
    return self;
}

- (void)setupDefaults
{
    self.itemSize           = CGSizeMake(100.0f, 30.0f);
    self.scrollDirection    = UICollectionViewScrollDirectionVertical;
    self.rowMargin          = 10.0f;
    self.columnsMargin      = 10.0f;
    self.sectionInset       = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    
    _itemAttributes = [NSMutableArray array];
}

- (void)prepareLayout
{
    [self.itemAttributes removeAllObjects];
    
    CGFloat originX = self.sectionInset.left;
    CGFloat originY = 0;
    
    originY += self.sectionInset.top;
    
    NSInteger items = [self.collectionView numberOfItemsInSection:0];
    
    // 遍历行
    for (NSInteger j = 0; j < items; j ++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:0];
        
        CGSize itemSize = [self.delegate labelListLayout:self sizeForItemAtIndexPath:indexPath];
        
        if (0 == j)
        {
            /// 初始化 contentH
            _contentHeight = (self.sectionInset.top + self.sectionInset.bottom + itemSize.height);
        }
        
        if ((originX + itemSize.width + self.sectionInset.right/2) > self.collectionView.frame.size.width)
        {
            originX = self.sectionInset.left;
            originY += itemSize.height + self.rowMargin;
            _contentHeight += (self.rowMargin + itemSize.height);
        }
        
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        attributes.frame = CGRectMake(originX, originY, itemSize.width, itemSize.height);
        [self.itemAttributes addObject:attributes];
        
        originX += itemSize.width + self.columnsMargin;
    }
}

- (CGSize)collectionViewContentSize
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(layoutDidFinish:)])
    {
        [self.delegate layoutDidFinish:self];
    }
        
    return CGSizeMake(self.collectionView.frame.size.width, self.contentHeight);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.itemAttributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    CGRect oldBounds = self.collectionView.bounds;
    
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    
    return NO;
}


@end
