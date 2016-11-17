//
//  WKBaseAnimator.h
//
//  Created by 王昆 on 16/11/16.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WKBaseAnimator : NSObject

@property (nonatomic, assign) NSTimeInterval duration;  /**< <#note#> */

@property (nonatomic, strong) id<UIViewControllerInteractiveTransitioning> interactiveTransitioning;

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext;
@end
