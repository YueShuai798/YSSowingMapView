//
//  ViewController.m
//  YSSowingMapView
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 shuai. All rights reserved.
//

#import "ViewController.h"
#import "YSSowingMapView.h"
#import "YYKit.h"

@interface ViewController ()
@property (strong, nonatomic)NSMutableArray *models;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.models =[NSMutableArray array];

    YSSowingMapModel *model =[YSSowingMapModel new];
    model.imageUrl =@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=4055016674,243230231&fm=11&gp=0.jpg";
    [self.models addObject:model];

    YSSowingMapModel *model1 =[YSSowingMapModel new];
    model1.imageUrl =@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=694600133,328786048&fm=27&gp=0.jpg";
    [self.models addObject:model1];

    YSSowingMapModel *model2 =[YSSowingMapModel new];
    model2.imageUrl =@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2078630274,1160517817&fm=27&gp=0.jpg";
    [self.models addObject:model2];

    YSSowingMapModel *model3 =[YSSowingMapModel new];
    model3.imageUrl =@"https://ss0.baidu.com/7Po3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=45e1c8e71ddfa9ece22e501752d1f754/342ac65c103853434cc02dda9f13b07eca80883a.jpg";
    [self.models addObject:model3];

    YSSowingMapView *mapView =[YSSowingMapView sowingMapViewWithModels:self.models frame:CGRectMake(0, 150, kScreenWidth, 220)];
    [self.view addSubview:mapView];
}


@end
