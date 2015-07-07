//
//  AcImageScrollView.m
//  广告循环滚动效果
//
//  Created by wrs on 15/4/20.
//  Copyright (c) 2015年 Qzy. All rights reserved.
//

#import "ACImageScrollView.h"
#import "WSBaseMacro.h"
#import "UIView+WSBaseUtil.h"

#define IMAGECHANGE_TIME    5.0

@interface ACImageScrollView () <UIScrollViewDelegate>
{
    BOOL isFirst;
    int currentInex;
    //循环滚动的周期时间
    NSTimer * _moveTime;
    //用于确定滚动式由人导致的还是计时器到了,系统帮我们滚动的,YES,则为系统滚动,NO则为客户滚动(ps.在客户端中客户滚动一个广告后,这个广告的计时器要归0并重新计时)
    BOOL _isTimeUp;
}

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (retain, nonatomic) UIImageView * leftImageView;
@property (retain, nonatomic) UIImageView * centerImageView;
@property (retain, nonatomic) UIImageView * rightImageView;
@property (retain, nonatomic) NSArray *imageNameArray;

@end

@implementation ACImageScrollView

+ (instancetype)getView
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:BASESTATICLIBRARY_BOUNDNAME withExtension:@"bundle"]];
    NSArray *array = [bundle loadNibNamed:@"ACImageScrollView" owner:nil options:nil];
    return [array firstObject];
}

- (void)awakeFromNib
{
    currentInex = 1;
    _scrollView.delegate = self;
 
    // 区域太小，没做点击事件
   // [_pageControl addTarget:self action:@selector(pageControlDidClick:) forControlEvents:UIControlEventValueChanged];

    isFirst = YES;
    _scrollView.bounces = NO;
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    
    _leftImageView = [[UIImageView alloc]init];
    _centerImageView = [[UIImageView alloc]init];
    _rightImageView = [[UIImageView alloc]init];
    NSArray *imageViewArray = @[_leftImageView, _centerImageView, _rightImageView];
    NSInteger itemCount = imageViewArray.count;
    for (int i = 0; i < itemCount; i++) {
        UIView *view = [imageViewArray objectAtIndex:i];
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestAction:)];
        [view addGestureRecognizer:tapGest];
         [_containerView addSubview:view];
//        view.translatesAutoresizingMaskIntoConstraints = NO;
//        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
//        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
//        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeWidth multiplier:1.0 / 3 constant:0];
//        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeRight multiplier:(1.0 * i / 3) constant:0];
//        [_containerView addConstraints:@[top, bottom, width, left]];
    }
    
    
    _moveTime = [NSTimer scheduledTimerWithTimeInterval:IMAGECHANGE_TIME target:self selector:@selector(animalMoveImage) userInfo:nil repeats:YES];
    _isTimeUp = NO;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_containerView autoresizingMaskSubViewsForHorizontalAverage:@[_leftImageView, _centerImageView, _rightImageView]];
    if (isFirst) {
        CGRect bounds = _scrollView.bounds;
        _scrollView.contentOffset = CGPointMake(bounds.size.width, 0);
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, bounds.size.height);
        isFirst = !isFirst;
    }
}

#pragma mark - tapGestAction
- (void)tapGestAction:(UITapGestureRecognizer *)tapGest
{
    NSLog(@"tap index:%d", currentInex);
    int dataIndex = currentInex - 1;
    // 修复只有一张图片是currentIndex = 1
    NSInteger imageCount = _imageNameArray.count;
    if (imageCount == 0) {
        dataIndex --;
    }
    if (dataIndex < _imageNameArray.count) {
        if (_callback) {
            _callback(dataIndex);
        }
    }
   
}

- (void)setImageData:(NSArray *)imageNames
{
    _pageControl.hidden = NO;
    _scrollView.scrollEnabled = YES;
    
    
    self.imageNameArray = imageNames;

    NSUInteger imageCount = _imageNameArray.count;
    if (imageCount == 0) {
        
    } else if (imageCount == 1) {
  
        [self setImageWithLeft:0 center:0 right:0];
        _pageControl.hidden = YES;
        _scrollView.scrollEnabled = NO;
        [_moveTime invalidate];
        
//        _leftImageView.image = [UIImage imageNamed:_imageNameArray[0]];
//        _centerImageView.image = [UIImage imageNamed:_imageNameArray[0]];
//        _rightImageView.image = [UIImage imageNamed:_imageNameArray[0]];
    } else if (imageCount == 2){
       
       [self setImageWithLeft:1 center:0 right:1];
//        _leftImageView.image = [UIImage imageNamed:_imageNameArray[1]];
//        _centerImageView.image = [UIImage imageNamed:_imageNameArray[0]];
//        _rightImageView.image = [UIImage imageNamed:_imageNameArray[1]];
    } else {
        
        [self setImageWithLeft:0 center:1 right:2];
    
//        _leftImageView.image = [UIImage imageNamed:_imageNameArray[0]];
//        _centerImageView.image = [UIImage imageNamed:_imageNameArray[1]];
//        _rightImageView.image = [UIImage imageNamed:_imageNameArray[2]];
    }
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = imageCount;
    
}

#pragma mark - 计时器到时,系统滚动图片
- (void)animalMoveImage
{
    [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width * 2, 0) animated:YES];
    _isTimeUp = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}


#pragma mark - 图片停止时,调用该函数使得滚动视图复用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
      //DLog(@"before center index:%d", currentInex);
    NSUInteger imageCount =  _imageNameArray.count;
    if (imageCount == 0) {
        return;
    }
    
    // 向右滚动
    if (_scrollView.contentOffset.x == 0)
    {
        if (currentInex == 0) {
            currentInex = (int)imageCount - 1;
        } else {
            currentInex = (currentInex - 1) % imageCount;
        }
        NSInteger currentPage = _pageControl.currentPage;
        if (currentPage == 0) {
            currentPage = _pageControl.numberOfPages - 1;
        } else {
            currentPage = (currentPage - 1) % _imageNameArray.count;
        }
        _pageControl.currentPage = currentPage;
    
    // 向左滚动
    } else if (_scrollView.contentOffset.x == _scrollView.bounds.size.width * 2) {
        currentInex = (currentInex + 1) % imageCount;
        _pageControl.currentPage = (_pageControl.currentPage + 1) % imageCount;
    } else {
        return;
    }
    
    NSInteger leftIndex = (currentInex - 1) % imageCount;
    NSInteger centerIndex = currentInex % imageCount;
    NSInteger rightIndex = (currentInex + 1) % imageCount;
    
    // 修正只有三张图片时的bug
    if (centerIndex == 0) {
        leftIndex = imageCount - 1;
        rightIndex = 1;
    }

   // DLog(@"center index:%d", (int)centerIndex);
    
    if (imageCount == 0) {
        
    } else if (imageCount == 1) {
       
        [self setImageWithLeft:0 center:0 right:0];
//        _leftImageView.image = [UIImage imageNamed:_imageNameArray[0]];
//        _centerImageView.image = [UIImage imageNamed:_imageNameArray[0]];
//        _rightImageView.image = [UIImage imageNamed:_imageNameArray[0]];
    } else if (imageCount == 2){
        [self setImageWithLeft:leftIndex center:centerIndex right:leftIndex];
//        _leftImageView.image = [UIImage imageNamed:_imageNameArray[leftIndex]];
//        _centerImageView.image = [UIImage imageNamed:_imageNameArray[centerIndex]];
//        _rightImageView.image = [UIImage imageNamed:_imageNameArray[leftIndex]];
    } else {
      [self setImageWithLeft:leftIndex center:centerIndex right:rightIndex];
        //        _leftImageView.image = [UIImage imageNamed:_imageNameArray[leftIndex]];
//        _centerImageView.image = [UIImage imageNamed:_imageNameArray[centerIndex]];
//        _rightImageView.image = [UIImage imageNamed:_imageNameArray[rightIndex]];
    }
    
    
    _scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width, 0);
    
    //手动控制图片滚动应该取消那个三秒的计时器
    if (!_isTimeUp) {
        [_moveTime setFireDate:[NSDate dateWithTimeIntervalSinceNow:IMAGECHANGE_TIME]];
    }
    _isTimeUp = NO;
}

- (void)setImageWithLeft:(NSInteger)left center:(NSInteger)center right:(NSInteger)right
{
    NSString *leftURL = [_imageNameArray objectAtIndex:left];
    NSString *centerURL = [_imageNameArray objectAtIndex:center];
    NSString *rightURL = [_imageNameArray objectAtIndex:right];
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:leftURL] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       // DLog(@"第%d张图片下载完", (int)left);
        [self downloadImageFinishCallBack:left image:image];

    }];
    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:centerURL] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       [self downloadImageFinishCallBack:center image:image];
    }];
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:rightURL] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
     [self downloadImageFinishCallBack:right image:image];
    }];
}

- (void)downloadImageFinishCallBack:(NSInteger)index image:(UIImage *)image
{
    if (_downloadImageFinish) {
        _downloadImageFinish(index, image);
    }
}

@end
