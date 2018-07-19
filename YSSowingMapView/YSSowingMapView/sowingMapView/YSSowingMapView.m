//
//  YSSowingMapView.m
//  YSSowingMapView
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 shuai. All rights reserved.
//

#import "YSSowingMapView.h"
#import "YYKit.h"

@interface YSSowingMapViewCell :UICollectionViewCell
@property (weak, nonatomic)UIImageView *iconView;
@property (strong, nonatomic)YSSowingMapModel *model;
@end
@implementation YSSowingMapViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {

        UIImageView *iconView =[UIImageView new];
        [self addSubview:iconView];
        self.iconView =iconView;
        iconView.layer.masksToBounds =YES;
    }
    return self;
}
- (void)setModel:(YSSowingMapModel *)model{
    _model =model;
    [self.iconView setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholder:nil];
    self.iconView.frame =CGRectMake(0, 0, self.width, self.height);
}

@end

@interface YSSowingMapView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/**
 滚动视图
 */
@property (strong, nonatomic)UICollectionView *collectionView;

/**
 滚动视图布局
 */
@property (strong, nonatomic)UICollectionViewFlowLayout *layout;

/**
 定时器
 */
@property (strong, nonatomic)NSTimer *timer;

/**
 数据源当前索引页
 */
@property (assign, nonatomic)NSUInteger currentIndex;

@end
@implementation YSSowingMapView

/**
 初始化轮播视图

 @param models 轮播图的数据
 @param frame 轮播图识图大小
 @return 返回轮播视图
 */
+ (instancetype)sowingMapViewWithModels:(NSArray<YSSowingMapModel *> *)models frame:(CGRect)frame{
    YSSowingMapView *sowingMapView =[[YSSowingMapView alloc]initWithFrame:frame];
    sowingMapView.models =models;

    return sowingMapView;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.backgroundColor =[UIColor whiteColor];

        [self addSubview:self.collectionView];
        self.collectionView.frame =self.bounds;

        UIPageControl *page =[UIPageControl new];
        [self addSubview:page];
        self.pageControl =page;
        page.backgroundColor =[UIColor clearColor];
        page.currentPageIndicatorTintColor =[UIColor blueColor];
        page.pageIndicatorTintColor =[UIColor whiteColor];
        page.hidesForSinglePage =YES;
        self.pageControl.currentPage =0;
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.pageControl.frame =CGRectMake(self.width -90, self.height -25, 80, 20);
}
- (void)setModels:(NSArray<YSSowingMapModel *> *)models{
    _models =models;
    [self.collectionView reloadData];
    if (_models.count) {
        self.pageControl.numberOfPages =_models.count;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        [self startTimer];
    }
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.collectionView.frame =self.bounds;
    [self.collectionView reloadData];
}
- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    self.collectionView.backgroundColor =backgroundColor;
}
- (void)timeFireMethod{
    // 取出当前显示cell
    NSIndexPath *indexPath = [self.collectionView indexPathsForVisibleItems].lastObject;
    NSInteger item =((indexPath.item + 1) > 2) ? 2 :(indexPath.item + 1);
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self scrollViewDidEndDecelerating:self.collectionView];
    });
}
#pragma mark - 时钟方法
- (void)startTimer {
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}
#pragma mark -UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.models.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YSSowingMapViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"YSSowingMapViewCell" forIndexPath:indexPath];
    NSUInteger index = [self indexWithOffset:indexPath.item];
    YSSowingMapModel *model =self.models[index];
    cell.model =model;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.width, self.height);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger index = [self indexWithOffset:indexPath.item];
    YSSowingMapModel *model =self.models[index];
    if ([self.delegate respondsToSelector:@selector(sowingMapView:selectedCurrentIocnWithIndex:andModel:)]) {
        [self.delegate sowingMapView:self selectedCurrentIocnWithIndex:index andModel:model];
    }
}
- (NSUInteger)indexWithOffset:(NSUInteger)offset {
    return (self.currentIndex + offset - 1 + self.models.count) % self.models.count;
}
#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 根据 contentOffset 判断当前的页面
    NSUInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.currentIndex = [self indexWithOffset:page];
    NSIndexPath *indexPath =[NSIndexPath indexPathForItem:1 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    self.pageControl.currentPage =self.currentIndex;

    [UIView setAnimationsEnabled:NO];
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    [UIView setAnimationsEnabled:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}

#pragma mark -geter
- (UICollectionView *)collectionView{
    self.layout =[[UICollectionViewFlowLayout alloc]init];
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.minimumLineSpacing =0;
    if (!_collectionView) {
        _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200) collectionViewLayout:self.layout];
        _collectionView.delegate =self;
        _collectionView.dataSource =self;
        _collectionView.pagingEnabled =YES;
        [_collectionView registerClass:[YSSowingMapViewCell class] forCellWithReuseIdentifier:@"YSSowingMapViewCell"];
        _collectionView.showsHorizontalScrollIndicator =NO;
    }
    return _collectionView;
}
-(NSTimer *)timer{
    if (!_timer) {
        _timer =[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    }
    return _timer;
}

@end
