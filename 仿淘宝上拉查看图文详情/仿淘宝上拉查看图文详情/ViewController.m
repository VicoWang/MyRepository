//
//  ViewController.m
//  仿淘宝上拉查看图文详情
//
//  Created by 王昆 on 16/11/7.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "ViewController.h"
#import "WKTestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Test";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    WKTestViewController *testVC = [[WKTestViewController alloc]init];
//    [self presentViewController:testVC animated:YES completion:nil];
    [self.navigationController pushViewController:testVC animated:YES];
}

@end
