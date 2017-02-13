//
//  ViewController.m
//  图片轮播demo
//
//  Created by m on 2017/2/13.
//  Copyright © 2017年 XLJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControll;

@end

@implementation ViewController
{
    NSTimer *_timer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatSubViews];
}

- (void)creatSubViews
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 20, self.view.bounds.size.width - 20, 200)];
    
    [self.view addSubview:self.scrollView];
    self.scrollView.delegate = self;

    CGFloat imageViewW = self.scrollView.bounds.size.width;
    CGFloat imageViewH = self.scrollView.bounds.size.height;
    
    for (NSInteger i = 1; i <= 5; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        CGFloat imageViewW = self.scrollView.bounds.size.width;
        CGFloat imageViewH = self.scrollView.bounds.size.height;
        CGFloat imageViewX = (i - 1) *imageViewW;
        CGFloat imageViewY = 0;
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%zd.jpg",i]];
        [self.scrollView addSubview:imageView];
    }
    
    self.scrollView.contentSize = CGSizeMake(5 * imageViewW, imageViewH);
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    
    [self addPageControll];
    
    //定时器
    [self startTimer];
}

- (void)timerDothing
{
    //获取当前页码
    
    NSInteger curentPage = self.pageControll.currentPage;
    curentPage++;
    
    if (curentPage == 5) {
        curentPage = 0;
    }
    
    CGFloat width = self.scrollView.bounds.size.width;
    CGPoint offset = CGPointMake(curentPage*width, 0);

    [self.scrollView setContentOffset:offset animated:YES];
    
}

- (void)addPageControll
{
    self.pageControll = [[UIPageControl alloc] initWithFrame:CGRectMake((self.scrollView.bounds.size.width-100)*0.5, self.scrollView.bounds.size.height - 20, 100, 20)];
    [self.view addSubview:self.pageControll];
    
    self.pageControll.numberOfPages = 5;
    self.pageControll.pageIndicatorTintColor = [UIColor greenColor];
    self.pageControll.currentPageIndicatorTintColor = [UIColor redColor];
    
    //自定义小圆点
//    [self.pageControll setValue:[UIImage imageNamed:@"当前页码的图片"] forKey:@"currentPageImage"];
//    [self.pageControll setValue:[UIImage imageNamed:@"所有小圆点的图片"] forKey:@"pageImage"];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //页码
    
    CGPoint offset = self.scrollView.contentOffset;
    CGFloat offsetX = offset.x;
    CGFloat width = self.scrollView.bounds.size.width;
    NSInteger pageNum = (offsetX + 0.5 * width) / width;
    
    self.pageControll.currentPage = pageNum;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //关闭定时器
    [self removeTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self startTimer];
}

- (void)startTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerDothing) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer
{
    [_timer invalidate];
    _timer = nil;
}

@end
