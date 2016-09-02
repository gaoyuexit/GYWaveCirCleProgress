//
//  GYBaseCell.h
//  GYNewDemo
//
//  Created by ronmei on 16/6/23.
//  Copyright © 2016年 郜宇. All rights reserved.
//

#import "UIView+GYExtension.h"

@implementation UIView (GYExtension)

- (void)setGy_x:(CGFloat)gy_x
{
    CGRect frame = self.frame;
    frame.origin.x = gy_x;
    self.frame = frame;
}

- (CGFloat)gy_x
{
    return self.frame.origin.x;
}

- (void)setGy_y:(CGFloat)gy_y
{
    CGRect frame = self.frame;
    frame.origin.y = gy_y;
    self.frame = frame;
}

- (CGFloat)gy_y
{
    return self.frame.origin.y;
}

- (void)setGy_w:(CGFloat)gy_w
{
    CGRect frame = self.frame;
    frame.size.width = gy_w;
    self.frame = frame;
}

- (CGFloat)gy_w
{
    return self.frame.size.width;
}

- (void)setGy_h:(CGFloat)gy_h
{
    CGRect frame = self.frame;
    frame.size.height = gy_h;
    self.frame = frame;
}

- (CGFloat)gy_h
{
    return self.frame.size.height;
}

- (void)setGy_size:(CGSize)gy_size
{
    CGRect frame = self.frame;
    frame.size = gy_size;
    self.frame = frame;
}

- (CGSize)gy_size
{
    return self.frame.size;
}

- (void)setGy_origin:(CGPoint)gy_origin
{
    CGRect frame = self.frame;
    frame.origin = gy_origin;
    self.frame = frame;
}

- (CGPoint)gy_origin
{
    return self.frame.origin;
}


- (void)setGy_centerX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)gy_centerX
{
    return self.center.x;
}

- (void)setGy_centerY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)gy_centerY
{
    return self.center.y;
}





@end
