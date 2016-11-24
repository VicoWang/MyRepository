//
//  UIScrollView+WKRefresh.m
//  UICollectionViewTest
//
//  Created by 王昆 on 16/11/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "UIScrollView+WKRefresh.h"
#import <MJRefresh/MJRefresh.h>

@implementation UIScrollView (WKRefresh)

static const char WKRefreshBeginRefreshCallBackKey = '\0';
- (void)setWk_beginRefreshCallBack:(void (^)(void))wk_beginRefreshCallBack {
    objc_setAssociatedObject(self, &WKRefreshBeginRefreshCallBackKey, wk_beginRefreshCallBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(void))wk_beginRefreshCallBack {
    return objc_getAssociatedObject(self, &WKRefreshBeginRefreshCallBackKey);
}

static const char WKRefreshBeginLoadMoreCallBackKey = '\0';
- (void)setWk_beginLoadMoreCallBack:(void (^)(void))wk_beginLoadMoreCallBack {
    objc_setAssociatedObject(self, &WKRefreshBeginLoadMoreCallBackKey, wk_beginLoadMoreCallBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(void))wk_beginLoadMoreCallBack {
    return objc_getAssociatedObject(self, &WKRefreshBeginLoadMoreCallBackKey);
}

- (void)wk_configureRefresh {
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.wk_beginRefreshCallBack) {
            strongSelf.wk_beginRefreshCallBack();
        }
    }];
    self.mj_header = header;
}

- (void)wk_configureLoadMore {
    __weak typeof(self) weakSelf = self;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.wk_beginLoadMoreCallBack) {
            strongSelf.wk_beginLoadMoreCallBack();
        }
    }];
    self.mj_footer = footer;
}

- (void)wk_configureRefreshAndLoadMore {
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.wk_beginRefreshCallBack) {
            strongSelf.wk_beginRefreshCallBack();
        }
    }];
    self.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.wk_beginLoadMoreCallBack) {
            strongSelf.wk_beginLoadMoreCallBack();
        }
    }];
    self.mj_footer = footer;
}

- (void)wk_beginRefresh {
    if (!self.mj_header.isRefreshing) {
        [self.mj_header beginRefreshing];
    }
}

- (void)wk_beginLoadMore {
    if (!self.mj_footer.isRefreshing) {
        [self.mj_footer beginRefreshing];
    }
}

- (void)wk_endRefresh {
    [self.mj_header endRefreshing];
}

- (void)wk_endLoadMore {
    [self.mj_footer endRefreshing];
}

- (void)wk_setRefreshEnable:(BOOL)enable {
    self.mj_header.hidden = !enable;
}

- (void)wk_setLoadMoreEnable:(BOOL)enable {
    self.mj_footer.hidden = !enable;
}

@end
