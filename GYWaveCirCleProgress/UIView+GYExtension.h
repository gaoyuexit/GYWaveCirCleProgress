//
//  GYBaseCell.h
//  GYNewDemo
//
//  Created by ronmei on 16/6/23.
//  Copyright © 2016年 郜宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GYExtension)
@property (assign, nonatomic) CGFloat gy_x;
@property (assign, nonatomic) CGFloat gy_y;
@property (assign, nonatomic) CGFloat gy_w;
@property (assign, nonatomic) CGFloat gy_h;
@property (assign, nonatomic) CGSize gy_size;
@property (assign, nonatomic) CGPoint gy_origin;

@property (nonatomic, assign) CGFloat gy_centerX;
@property (nonatomic, assign) CGFloat gy_centerY;


@end
