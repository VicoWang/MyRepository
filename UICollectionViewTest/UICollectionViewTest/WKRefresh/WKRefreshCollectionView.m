//
//  WKRefreshCollectionView.m
//  UICollectionViewTest
//
//  Created by 王昆 on 16/11/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "WKRefreshCollectionView.h"


@implementation WKRefreshCollectionView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self setRefreshFooter];
        [self setRefreshHeader];
    }
    return self;
}

#pragma mark - public methods
- (void)beginRefresh {
    if (!self.mj_header.isRefreshing) {
        [self.mj_header beginRefreshing];
    }
}

- (void)beginLoadMore {
    if (!self.mj_footer.isRefreshing) {
        [self.mj_footer beginRefreshing];
    }
}

- (void)endRefresh {
    [self.mj_header endRefreshing];
}

- (void)endLoadMore {
    [self.mj_footer endRefreshing];
}

- (void)setRefreshEnable:(BOOL)enable {
    self.mj_header.hidden = !enable;
    
}

- (void)setLoadMoreEnable:(BOOL)enable {
    self.mj_footer.hidden = !enable;
}

#pragma mark - private methods
- (void)setRefreshHeader {
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.beginRefreshCallBack) {
            strongSelf.beginRefreshCallBack();
        }
    }];
    self.mj_header = header;
}

- (void)setRefreshFooter {
    __weak typeof(self) weakSelf = self;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.beginLoadMoreCallBack) {
            strongSelf.beginLoadMoreCallBack();
        }
    }];
    self.mj_footer = footer;
}

@end
