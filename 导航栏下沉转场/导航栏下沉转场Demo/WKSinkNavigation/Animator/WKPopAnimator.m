//
//  WKPopAnimator.m
//
//  Created by 王昆 on 16/11/16.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "WKPopAnimator.h"
#import "WKSinkNavigationControllerConst.h"

@interface WKPopAnimator ()
@property (nonatomic, strong) UIView *blackMask;
@end

@implementation WKPopAnimator

#pragma mark - UIViewControllerAnimatedTransitioning
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    //目标控制器
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //源控制器
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //控制器栈
    UIView *container = [transitionContext containerView];
    [container insertSubview:toVc.view belowSubview:fromVc.view];
    
    UIView *blackMask = [[UIView alloc] init];
    self.blackMask = blackMask;
    blackMask.backgroundColor = [UIColor blackColor];
    blackMask.frame = CGRectMake(0, 0, WKScreenWidth, WKScreenHeight);
    [container insertSubview:self.blackMask aboveSubview:toVc.view];
    
    float scale = WKSinkNavigationControllerLastScreenShotScale;
    toVc.view.transform = CGAffineTransformMakeScale(scale, scale);
    self.blackMask.alpha = WKSinkNavigationControllerBlackMaskAlpha;
    fromVc.view.wk_x = 0;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateKeyframesWithDuration:self.duration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        // 动画效果
        toVc.view.transform = CGAffineTransformIdentity;
        fromVc.view.wk_x = WKScreenWidth;
        weakSelf.blackMask.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [weakSelf.blackMask removeFromSuperview];
        [fromVc.view removeFromSuperview];
        //如果遇到未知取消操作恢复栈结构
        if (transitionContext.transitionWasCancelled) {
            [container addSubview:fromVc.view];
        }
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
