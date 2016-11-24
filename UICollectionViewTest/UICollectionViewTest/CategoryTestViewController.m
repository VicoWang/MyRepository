//
//  CategoryTestViewController.m
//  UICollectionViewTest
//
//  Created by 王昆 on 16/11/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "CategoryTestViewController.h"
#import "TestCollectionViewCell.h"
#import "UIScrollView+WKRefresh.h"

@interface CategoryTestViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation CategoryTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"category test";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TestCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

#pragma mark - getters

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(self.view.bounds.size.width, 50);
        layout.minimumLineSpacing = 10;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [UIColor orangeColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"TestCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TestCollectionViewCell"];
        
        /** category */ 
        [_collectionView wk_configureRefreshAndLoadMore];
        _collectionView.wk_beginRefreshCallBack = ^{
            NSLog(@"刷新");
        };
        _collectionView.wk_beginLoadMoreCallBack = ^{
            NSLog(@"加载更多");
        };
    }
    return _collectionView;
}


@end
