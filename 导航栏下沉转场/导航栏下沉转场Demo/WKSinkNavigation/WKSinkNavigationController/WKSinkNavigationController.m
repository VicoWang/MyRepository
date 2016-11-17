//
//  WKSinkNavigationController.m
//
//  Created by 王昆 on 16/11/16.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "WKSinkNavigationController.h"
#import "WKSinkNavigationControllerConst.h"

@interface WKSinkNavigationController () <UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray *screenShotList; /**< 存储截屏图片的数组 */
@property (nonatomic, assign) CGPoint startTouchPoint; /**< 开始滑动的点 */
@property (nonatomic, strong) UIView *bgContainer; /**< 背景容器 */
@property (nonatomic, strong) UIImageView *lastScreenShotView; /**< push之前的屏幕快照 */
@property (nonatomic, strong) UIView *blackMask;  /**< 遮罩 */
@property (nonatomic, weak) UIViewController *mostRecentController; /**< 最新的控制器 */

@end

@implementation WKSinkNavigationController

#pragma mark - override
- (void)viewDidLoad {
    [super viewDidLoad];
    self.screenShotList = [NSMutableArray arrayWithCapacity:2];
    self.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.screenShotList addObject:[self capture]];
    
    if (self.viewControllers.count > 0) {
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        panGesture.maximumNumberOfTouches = 1;
        [self.view addGestureRecognizer:panGesture];
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    [self.screenShotList removeLastObject];
    return [super popViewControllerAnimated:animated];
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    if([_mostRecentController respondsToSelector:@selector(navigationController:interactionControllerForAnimationController:)]) {
        return [(id<UINavigationControllerDelegate>)_mostRecentController navigationController:navigationController interactionControllerForAnimationController:animationController];
    }
    return nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    SEL selector = @selector(navigationController:animationControllerForOperation:fromViewController:toViewController:);
    id<UIViewControllerAnimatedTransitioning> result = nil;
    
    if([fromVC respondsToSelector:selector]) {
        
        result = [(id<UINavigationControllerDelegate>)fromVC navigationController:navigationController animationControllerForOperation:operation fromViewController:fromVC toViewController:toVC];
        if(result) {
            self.mostRecentController = fromVC;
        }
        
    } else if([toVC respondsToSelector:selector]) {
        
        result = [(id<UINavigationControllerDelegate>)toVC navigationController:navigationController animationControllerForOperation:operation fromViewController:fromVC toViewController:toVC];
        if(result) {
            self.mostRecentController = toVC;
        }
    }
    return result;
}

#pragma mark - event response
- (void)panGestureAction:(UIPanGestureRecognizer *)panGesture {
    if (self.viewControllers.count <= 1) return;
    //获取手指在屏幕上的点
    CGPoint touchPoint = [panGesture locationInView:[UIApplication sharedApplication].keyWindow];
    
    //开始滑动
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        //记录初始位置
        _startTouchPoint = touchPoint;
        
        //创建背景View
        UIView *bgContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.bgContainer = bgContainer;
        [self.view.superview insertSubview:bgContainer belowSubview:self.view];
        self.bgContainer.hidden = NO;
        
        //带透明黑色遮罩
        UIView *blackMask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.wk_width, self.view.wk_height)];
        self.blackMask = blackMask;
        blackMask.backgroundColor = [UIColor blackColor];
        [self.bgContainer addSubview:blackMask];
        
        //释放之前的屏幕快照View
        if (self.lastScreenShotView) {
            [self.lastScreenShotView removeFromSuperview];
            self.lastScreenShotView = nil;
        }
        
        //屏幕快照
        UIImage *lastScreenShot = [self.screenShotList lastObject];
        UIImageView *lastScreenShotView = [[UIImageView alloc] initWithImage:lastScreenShot];
        self.lastScreenShotView = lastScreenShotView;
        [self.bgContainer insertSubview:self.lastScreenShotView belowSubview:self.blackMask];
        
    //滑动结束
    } else if (panGesture.state == UIGestureRecognizerStateEnded) {
        
        if (touchPoint.x - _startTouchPoint.x > WKSinkNavigationControllerPanGestureRespondMinSapce) {
            //触发响应
            [UIView animateWithDuration:WKSinkNavigationControllerPushOrPopAnimationDuration animations:^{
                
                [self moveViewWithX:[UIScreen mainScreen].bounds.size.width];
            } completion:^(BOOL finished) {
                
                [self popViewControllerAnimated:NO];
                //复原self.view的frame
                self.view.wk_x = 0;
                // 拖动完毕后释放背景View
                if (self.bgContainer) {
                    [self.bgContainer removeFromSuperview];
                    self.bgContainer = nil;
                }
            }];
        
        } else {
            //不触发响应，复原
            [UIView animateWithDuration:WKSinkNavigationControllerPushOrPopAnimationDuration animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                self.bgContainer.hidden = YES;
                // 拖动完毕后释放背景View
                if (self.bgContainer) {
                    [self.bgContainer removeFromSuperview];
                    self.bgContainer = nil;
                }
            }];
        }
        
    //滑动手势取消
    } else if (panGesture.state == UIGestureRecognizerStateCancelled) {
        //复原
        [UIView animateWithDuration:WKSinkNavigationControllerPushOrPopAnimationDuration animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            
            self.bgContainer.hidden = YES;
        }];
        
    //滑动中
    } else if (panGesture.state == UIGestureRecognizerStateChanged) {
        
        [self moveViewWithX:touchPoint.x - _startTouchPoint.x];
    }
}

#pragma mark - private methods
- (void)moveViewWithX:(CGFloat)x {
    x = MIN(WKScreenWidth, x);
    x = MAX(x, 0);
    self.view.wk_x = x;
    
    CGFloat scale = (x / WKScreenWidth * (1-WKSinkNavigationControllerLastScreenShotScale)) + WKSinkNavigationControllerLastScreenShotScale;  // 0~0.05  * 375 + 最小0.95
    CGFloat alpha = WKSinkNavigationControllerBlackMaskAlpha - (x / WKScreenWidth *WKSinkNavigationControllerBlackMaskAlpha);  // 0.4 - 1  最大透明度 0.4
    
    self.lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
    self.blackMask.alpha = alpha;
}

- (UIImage *)capture {
    UIGraphicsBeginImageContextWithOptions(self.view.wk_size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
