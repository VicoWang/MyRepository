//
//  UIViewController+WKSinkNavigationController.m
//
//  Created by 王昆 on 16/11/16.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "UIViewController+WKSinkNavigationController.h"
#import "WKPushAnimator.h"
#import "WKPopAnimator.h"

@interface UIViewController () <UINavigationControllerDelegate>

@end

@implementation UIViewController (WKSinkNavigationController)

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    if([animationController isKindOfClass:[WKBaseAnimator class]]) {
        return ((WKBaseAnimator *)animationController).interactiveTransitioning;
    }
    return nil;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if(operation == UINavigationControllerOperationPush) {
        
        WKPushAnimator *pushAnimator = [[WKPushAnimator alloc] init];
        return pushAnimator;
    } else if (operation == UINavigationControllerOperationPop) {
        
        WKPopAnimator *popAnimator = [[WKPopAnimator alloc] init];
        return popAnimator;
    }
    return nil;
}

@end
