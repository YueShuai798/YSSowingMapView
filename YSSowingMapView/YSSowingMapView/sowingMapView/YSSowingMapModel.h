//
//  YSSowingMapModel.h
//  YSSowingMapView
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 shuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSSowingMapModel : NSObject

/**
 图片地址
 */
@property (copy, nonatomic)NSString *imageUrl;

/**
 跳转对象，自己的实际使用的对象，方便使用者使用
 */
@property (strong, nonatomic)id object;

@end
