//
//  MJViewController.m
//  scrollView-图片分页
//
//  Created by 朱正晶 on 15/2/15.
//  Copyright (c) 2015年 China. All rights reserved.
//

#import "MJViewController.h"

#define kImageCount 8

@interface MJViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property UIPageControl *pageControl;
@end

@implementation MJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    
    for (int i = 0; i < kImageCount; i++) {
        // 1. 加载图片
        UIImageView * imageView = [[UIImageView alloc] init];
        NSString *imageName = [NSString stringWithFormat:@"0%d.jpg", i+1];
        imageView.image = [UIImage imageNamed:imageName];
        imageView.frame = CGRectMake(i * w, 0, w, h);
        
        [_scrollView addSubview:imageView];
    }
    
    _scrollView.contentSize = CGSizeMake(kImageCount*w, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = kImageCount;
    pageControl.center = CGPointMake(w * 0.5, h - 20);
    pageControl.bounds = CGRectMake(0, 0, 150, 50);
    pageControl.pageIndicatorTintColor = [UIColor redColor];
    pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    
    _pageControl = pageControl;
    [self.view addSubview:pageControl];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    _pageControl.currentPage = page;
}

@end
