//
//  WKBaseAnimator.m
//
//  Created by 王昆 on 16/11/16.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "WKBaseAnimator.h"
#import "WKSinkNavigationControllerConst.h"

@implementation WKBaseAnimator
- (instancetype)init {
    if (self = [super init]) {

        _duration = WKSinkNavigationControllerPushOrPopAnimationDuration;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return _duration;
}

@end
