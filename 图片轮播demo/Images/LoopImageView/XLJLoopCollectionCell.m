//
//  XLJLoopCollectionCell.m
//  图片轮播器
//
//  Created by m on 2017/2/9.
//  Copyright © 2017年 XLJ. All rights reserved.
//

#import "XLJLoopCollectionCell.h"

@implementation XLJLoopCollectionCell
{
    UIImageView *_imageView;
}

//这里的frame已经设置好了，是因为XLJLoopFlowLayout就已经确定了的
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //添加图像
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_imageView];
       
    }
    
    return self;
}

- (void)setUrl:(NSURL *)url
{
    _url = url;
    //1.根据url获取二进制数据
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    UIImage *image = [UIImage imageWithData:data];
    
    _imageView.image = image;
}

@end
