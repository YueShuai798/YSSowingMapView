//
//  YSSowingMapView.h
//  YSSowingMapView
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 shuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSSowingMapModel.h"


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
@end
