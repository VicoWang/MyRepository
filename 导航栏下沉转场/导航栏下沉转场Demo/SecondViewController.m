//
//  SecondViewController.m
//  导航栏下沉转场Demo
//
//  Created by 王昆 on 16/11/16.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(100, 100, 60, 40);
    btn1.backgroundColor = [UIColor orangeColor];
    [btn1 addTarget:self action:@selector(clickBtnAction1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(200, 100, 60, 40);
    btn2.backgroundColor = [UIColor orangeColor];
    [btn2 addTarget:self action:@selector(clickBtnAction2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)clickBtnAction1 {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickBtnAction2 {
    ThirdViewController *secondVC = [[ThirdViewController alloc]init];
    [self.navigationController pushViewController:secondVC animated:YES];
}

@end
