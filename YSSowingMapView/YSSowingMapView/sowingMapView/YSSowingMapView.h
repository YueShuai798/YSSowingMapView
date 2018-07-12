//
//  YSSowingMapView.h
//  YSSowingMapView
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 shuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSSowingMapModel.h"
@class YSSowingMapView;
@protocol YSSowingMapViewDelegate<NSObject>


/**
 点击轮播图的某张图的事件

 @param sowingMapView sowingMapView
 @param index 点击的图片的索引
 @param mapModel 展示图片的对象
 */
- (void)sowingMapView:(YSSowingMapView *)sowingMapView selectedCurrentIocnWithIndex:(NSUInteger)index andModel:(YSSowingMapModel *)mapModel;
@end

@interface YSSowingMapView : UIView

/**
 初始化轮播视图

 @param models 轮播图的数据
 @param frame 轮播图识图大小
 @return 返回轮播视图
 */
+ (instancetype)sowingMapViewWithModels:(NSArray<YSSowingMapModel *> *)models frame:(CGRect)frame;


/**
 轮播图的数据
 */
@property (strong, nonatomic)NSArray<YSSowingMapModel *> *models;

/**
 小点点
 */
@property (weak, nonatomic)UIPageControl *pageControl;

/**
 轮播图的代理
 */
@property (weak, nonatomic)id<YSSowingMapViewDelegate>delegate;
@end
