//
//  WKSinkNavigationControllerConst.h
//
//  Created by 王昆 on 16/11/16.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+WKFrameLayout.h"

#define WKScreenWidth [UIScreen mainScreen].bounds.size.width
#define WKScreenHeight [UIScreen mainScreen].bounds.size.height

extern CGFloat const WKSinkNavigationControllerBlackMaskAlpha; /**< 遮罩透明度 */
extern CGFloat const WKSinkNavigationControllerLastScreenShotScale; /**< 缩小比例 */
extern CGFloat const WKSinkNavigationControllerPanGestureRespondMinSapce; /**< 滑动触发响应push/pop的最小距离 */
extern CGFloat const WKSinkNavigationControllerPushOrPopAnimationDuration; /**< 动画时长 */

