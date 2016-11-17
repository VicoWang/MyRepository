//
//  UIView+WKFrameLayout.h
//
//  Created by 王昆 on 16/11/17.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WKFrameLayout)

@property (nonatomic, assign) CGFloat wk_x;
@property (nonatomic, assign) CGFloat wk_y;
@property (nonatomic, assign) CGFloat wk_width;
@property (nonatomic, assign) CGFloat wk_height;
@property (nonatomic, assign) CGFloat wk_centerX;
@property (nonatomic, assign) CGFloat wk_centerY;
@property (nonatomic, assign) CGPoint wk_origin;
@property (nonatomic, assign) CGSize  wk_size;

@end
