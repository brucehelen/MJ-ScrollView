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
@property BOOL displayFlag;
@end

@implementation MJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;

    // 1. 加载两张图片
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"01.jpg"];
    imageView.frame = CGRectMake(0, 0, w, h);
    [_scrollView addSubview:imageView];
    
    /*
    imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"02.jpg"];
    imageView.frame = CGRectMake(320, 0, w, h);
    
    [_scrollView addSubview:imageView];
    */
    NSLog(@"count = %d", _scrollView.subviews.count);
    NSLog(@"subviews = %@", _scrollView.subviews);
    
    [_scrollView.subviews[0] removeFromSuperview];
    [_scrollView.subviews[0] removeFromSuperview];
    
    NSLog(@"count = %d", _scrollView.subviews.count);
    NSLog(@"subviews = %@", _scrollView.subviews);


    /*
    [_scrollView.subviews[2] removeFromSuperview];
    
    NSLog(@"count = %d", _scrollView.subviews.count);
    NSLog(@"subviews = %@", _scrollView.subviews);
    */
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
    
    _displayFlag = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    CGFloat x = scrollView.contentOffset.x;
    NSLog(@"x = %f", x);
    
    // 显示pageControl页面
    int page = x / scrollView.frame.size.width;
    _pageControl.currentPage = page;
    CGFloat left = x - scrollView.frame.size.width * page;
    
    NSLog(@"page = %d, left = %f", page, left);
    
    if ( left > 0.0 && _displayFlag == NO) {
        //[_scrollView.subviews[3] removeFromSuperview];
        NSLog(@"subviews0 = %@", _scrollView.subviews);
        UIImageView * imageView = [[UIImageView alloc] init];
        NSString *imageName = [NSString stringWithFormat:@"0%d.jpg", page + 2];
        imageView.image = [UIImage imageNamed:imageName];
        imageView.frame = CGRectMake((page + 1) * w, 0, w, h);
        [_scrollView addSubview:imageView];
        _displayFlag = YES;
        NSLog(@"subviews1 = %@", _scrollView.subviews);
    }
    
    if (left == 0.0 && page % 2 == 1) {
        NSLog(@"subviews2 = %@", _scrollView.subviews);
        _displayFlag = NO;
        [_scrollView.subviews[0] removeFromSuperview];
        
        NSLog(@"subviews3 = %@", _scrollView.subviews);
    } else if (left == 0.0 && page % 2 == 0) {
        NSLog(@"subviews4 = %@", _scrollView.subviews);
        _displayFlag = NO;
        [_scrollView.subviews[3] removeFromSuperview];
        NSLog(@"subviews = %@", _scrollView.subviews);
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging");
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndScrollingAnimation");
}

@end
