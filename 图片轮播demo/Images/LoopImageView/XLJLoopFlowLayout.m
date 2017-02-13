//
//  XLJLoopFlowLayout.m
//  图片轮播器
//
//  Created by m on 2017/2/9.
//  Copyright © 2017年 XLJ. All rights reserved.
//

#import "XLJLoopFlowLayout.h"

@implementation XLJLoopFlowLayout

//在collectionView在第一次布局的时候，被调用，此时collectionView的frame已经设置完毕
- (void)prepareLayout
{
    [super prepareLayout];
    
    //直接使用collectionView的属性设置布局
    self.itemSize = self.collectionView.bounds.size;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

@end
