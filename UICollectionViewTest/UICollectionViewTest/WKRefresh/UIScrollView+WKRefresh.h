//
//  UIScrollView+WKRefresh.h
//  UICollectionViewTest
//
//  Created by 王昆 on 16/11/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (WKRefresh)

@property (nonatomic, copy) void(^wk_beginRefreshCallBack)(void); /** 开始刷新的回调 */
@property (nonatomic, copy) void(^wk_beginLoadMoreCallBack)(void); /**< 开始加载更多的回调 */

/** 开启刷新功能 */
- (void)wk_configureRefresh;
/** 开启加载更多功能 */
- (void)wk_configureLoadMore;
/** 开启刷新和加载更多功能 */
- (void)wk_configureRefreshAndLoadMore;


/** 开始刷新 */
- (void)wk_beginRefresh;
/** 开始加载更多 */
- (void)wk_beginLoadMore;

/** 停止刷新 */
- (void)wk_endRefresh;
/** 停止加载更多 */
- (void)wk_endLoadMore;

/** 设置下拉刷新状态 */
- (void)wk_setRefreshEnable:(BOOL)enable;
/** 设置上提加载更多状态 */
- (void)wk_setLoadMoreEnable:(BOOL)enable;

@end
