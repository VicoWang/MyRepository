//
//  ViewController.m
//  UICollectionViewTest
//
//  Created by 王昆 on 16/11/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "CategoryTestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)test:(id)sender {
    TestViewController *testVC = [[TestViewController alloc]init];
    [self.navigationController pushViewController:testVC animated:YES];
}
- (IBAction)categoryTest:(id)sender {
    CategoryTestViewController *categoryVC = [[CategoryTestViewController alloc]init];
    [self.navigationController pushViewController:categoryVC animated:YES];
}


@end
