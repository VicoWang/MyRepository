//
//  WKRefreshCollectionView.h
//  UICollectionViewTest
//
//  Created by 王昆 on 16/11/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

@interface WKRefreshCollectionView : UICollectionView

@property (nonatomic, copy) void(^beginRefreshCallBack)(void); /** 开始刷新的回调 */
@property (nonatomic, copy) void(^beginLoadMoreCallBack)(void); /**< 开始加载更多的回调 */

/** 开始刷新 */
- (void)beginRefresh;
/** 开始加载更多 */
- (void)beginLoadMore;

/** 停止刷新 */
- (void)endRefresh;
/** 停止加载更多 */
- (void)endLoadMore;

/** 设置下拉刷新状态 */
- (void)setRefreshEnable:(BOOL)enable;
/** 设置上提加载更多状态 */
- (void)setLoadMoreEnable:(BOOL)enable;

@end
