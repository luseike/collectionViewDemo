//
//  CircleLayout.m
//  collectionViewDemo
//
//  Created by jyl on 14-11-5.
//  Copyright (c) 2014年 jyl. All rights reserved.
//

#import "CircleLayout.h"

#define ITEM_SIZE 40

@interface CircleLayout()
@property(nonatomic,strong) NSMutableArray *deleteIndexPath;
@property(nonatomic,strong) NSMutableArray *insertIndexPath;
@end

@implementation CircleLayout

-(void)prepareLayout{
    [super prepareLayout];
    
    //布局准备中定义了一些之后计算所需要用到的参数
    CGSize size=self.collectionView.frame.size;
    _cellCount=[[self collectionView] numberOfItemsInSection:0];
    _center=CGPointMake(size.width*0.5, size.height*0.5);
    _radius=MIN(size.width, size.height)/2.5;
}

-(CGSize)collectionViewContentSize{
    //整个collectionView的内容就是collectionView的大小（没有滚动）
    return [self collectionView].frame.size;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    //通过所在的indexPath确定位置
    UICollectionViewLayoutAttributes *attributes=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size=CGSizeMake(ITEM_SIZE, ITEM_SIZE);
    attributes.center=CGPointMake(_center.x+_radius*cosf(2*indexPath.item*M_PI/_cellCount), _center.y+_radius*sinf(2*indexPath.item*M_PI/_cellCount));
    return attributes;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    //用来在一开始给出一套UICollectionViewLayoutAttributes
    NSMutableArray *attributes=[NSMutableArray array];
    for (NSInteger i=0; i<self.cellCount; i++) {
        NSIndexPath *indexPath=[NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}

-(void)prepareForCollectionViewUpdates:(NSArray *)updateItems{
    [super prepareForCollectionViewUpdates:updateItems];
    
    self.deleteIndexPath=[NSMutableArray array];
    self.insertIndexPath=[NSMutableArray array];
    
    for (UICollectionViewUpdateItem *update in updateItems) {
        if (update.updateAction==UICollectionUpdateActionDelete) {
            [self.deleteIndexPath addObject:update.indexPathBeforeUpdate];
        }else if (update.updateAction==UICollectionUpdateActionInsert){
            [self.insertIndexPath addObject:update.indexPathAfterUpdate];
        }
    }
}

-(void)finalizeCollectionViewUpdates{
    [super finalizeCollectionViewUpdates];
    self.deleteIndexPath=nil;
    self.insertIndexPath=nil;
}

//-(UICollectionViewLayoutAttributes *)initialLayoutAttributesForInsertedItemAtIndexPath:(NSIndexPath *)itemIndexPath{
//    UICollectionViewLayoutAttributes *attributes=[self layoutAttributesForItemAtIndexPath:itemIndexPath];
//    attributes.alpha=0.0;
//    attributes.center=CGPointMake(_center.x, _center.y);
//    return attributes;
//}
//
//- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDeletedItemAtIndexPath:(NSIndexPath *)itemIndexPath{
//    UICollectionViewLayoutAttributes *attributes=[self layoutAttributesForItemAtIndexPath:itemIndexPath];
//    attributes.alpha=0.0;
//    attributes.center=CGPointMake(_center.x, _center.y);
//    attributes.transform3D=CATransform3DMakeScale(0.1, 0.1, 1.0);
//    return attributes;
//}

-(UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath{
    UICollectionViewLayoutAttributes *attributes=[super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    
    if ([self.insertIndexPath containsObject:itemIndexPath]) {
        if (!attributes) {
            attributes=[self layoutAttributesForItemAtIndexPath:itemIndexPath];
            
            attributes.alpha=0.0;
            attributes.center=CGPointMake(_center.x, _center.y);
        }
    }
    return attributes;
}

-(UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath{
    UICollectionViewLayoutAttributes *attributes=[super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    if ([self.deleteIndexPath containsObject:attributes]) {
        if (!attributes) {
            attributes=[self layoutAttributesForItemAtIndexPath:itemIndexPath];
            
            attributes.alpha=0.0;
            attributes.center=CGPointMake(_center.x, _center.y);
            attributes.transform3D=CATransform3DMakeScale(0.1, 0.1, 1.0);
        }
    }
    return attributes;
}

@end
