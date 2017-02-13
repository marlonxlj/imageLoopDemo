//
//  XLJRunLoopView.m
//  图片轮播器
//
//  Created by m on 2017/2/9.
//  Copyright © 2017年 XLJ. All rights reserved.
//

#import "XLJRunLoopView.h"
#import "XLJLoopFlowLayout.h"
#import "XLJLoopCollectionCell.h"

NSString *const XLJLoopViewID = @"XLJLoopViewID";

@interface XLJRunLoopView()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation XLJRunLoopView
{
    NSArray <NSURL *> *_urls;
}
- (instancetype)initWithURLs:(NSArray <NSURL *> *)urls{
    self = [super initWithFrame:CGRectZero collectionViewLayout:[[XLJLoopFlowLayout alloc] init]];
    if (self) {
        _urls = urls;
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[XLJLoopCollectionCell class] forCellWithReuseIdentifier:XLJLoopViewID];
        
        //初始显示第二组
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_urls.count inSection:0];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        });
        
        
        
    }
    
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _urls.count * 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XLJLoopCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XLJLoopViewID forIndexPath:indexPath];
    
    cell.url = _urls[indexPath.item%_urls.count];
                                                                                                                                      
    return cell;
}

#pragma mark --Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //获取当前的页数
    NSInteger offset = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    //第0页，跳转到，第1组的第0页
    //最后一页跳转到第0组的最后一页
    if (offset == 0 || offset == [self numberOfItemsInSection:0] - 1) {
        
        //第0页
        if (offset == 0) {
            offset = _urls.count;
        }else{
            offset = _urls.count - 1;
        }
        //重新调整位置
        scrollView.contentOffset = CGPointMake(offset * scrollView.bounds.size.width, 0);
    }
}

@end
