//
//  GYWaveCircleProgressView.m
//  GYWaveCirCleProgress
//
//  Created by ronmei on 16/9/1.
//  Copyright © 2016年 gaoyu. All rights reserved.
//

#import "GYWaveCircleProgressView.h"
#import "UIView+GYExtension.h"
#define RGBA(r, g, b, a)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)     RGBA(r, g, b, 1.0f)

@interface GYWaveCircleProgressView ()

@property (nonatomic, strong) CAShapeLayer      *backgroundLayer;
@property (nonatomic, strong) CAShapeLayer      *progressLayer;
@property (nonatomic, strong) UIImageView       *bigImg;
@property (nonatomic, strong) UIImageView       *pointImg;

@property (nonatomic, strong) UILabel           *progressLabel;


@property (nonatomic, assign) CGFloat           percentag;
@property (nonatomic, assign) CFTimeInterval    duration;
@property (nonatomic, weak)   NSTimer           *timer;
@property (nonatomic, assign) CGFloat           sumSteps;


@end




@implementation GYWaveCircleProgressView

- (instancetype)initWithFrame:(CGRect)frame setProgress:(CGFloat)percentag Duration:(CFTimeInterval)duration
{
    self = [super initWithFrame:frame];
    if (self) {
        _percentag = percentag;
        _duration = duration;
        _sumSteps = 0.0;

        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        bgView.backgroundColor = [UIColor clearColor];
        [self addSubview:bgView];
        
        
        UIImageView *bigImg = [[UIImageView alloc] init];
        bigImg.image = [UIImage imageNamed:@"fb_wave"];
        [bgView addSubview:bigImg];
        self.bigImg = bigImg;
        // 看不见的位置(类似右下角)
        self.bigImg.frame = CGRectMake(0, bgView.gy_h, 3*frame.size.width, frame.size.height);
        
        // 将bgView变成圆形, 然后切除超出的部分, 这里可以注释下面三句代码,就明白了
        bigImg.alpha = 0.2;
        bgView.layer.cornerRadius = self.gy_w/2;
        bgView.clipsToBounds = YES;
        
        
        
        
        
        
        
        _backgroundLayer = [CAShapeLayer layer];
        _backgroundLayer.frame = self.bounds;
        _backgroundLayer.lineWidth = 8;
        _backgroundLayer.strokeColor = [UIColor whiteColor].CGColor;
        _backgroundLayer.fillColor = nil;
        UIBezierPath *backgroundPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x, self.center.y) radius:(self.bounds.size.width-8)/2 startAngle:0 endAngle:M_PI*2 clockwise:YES];
        _backgroundLayer.path = backgroundPath.CGPath;
        [bgView.layer addSublayer:_backgroundLayer];

        _progressLayer = [CAShapeLayer layer];
        _progressLayer.frame = self.bounds;
        _progressLayer.lineWidth = 8;
        _progressLayer.strokeColor = [UIColor whiteColor].CGColor;
        _progressLayer.fillColor = nil;
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.lineJoin = kCALineCapRound;
        
        UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x, self.center.y) radius:(self.bounds.size.width-8)/2 startAngle:-M_PI_2 endAngle:-M_PI_2 + M_PI *2 clockwise:YES];
        _progressLayer.path = progressPath.CGPath;
        [bgView.layer addSublayer:_progressLayer];
        
        
        
        /*为进度条实现颜色渐变
         *把左半边设置一个颜色渐变，右半边上下部分各设置颜色渐变（效果同在颜色数组里设置更多个颜色）
         */
        //左半边实现颜色渐变
        CALayer *gradientLayer = [CALayer layer];
        CAGradientLayer *gradientLayer1 =  [CAGradientLayer layer];
        gradientLayer1.frame = CGRectMake(0, 0, frame.size.width/2, frame.size.height);
        [gradientLayer1 setColors:[NSArray arrayWithObjects:(id)[RGB(252, 200, 83) CGColor],(id)[RGB(209, 172.5, 108) CGColor],(id)[RGB(208, 173, 108) CGColor],(id)[RGB(205, 172, 106) CGColor],(id)[RGB(205, 173, 106) CGColor], nil]];
        [gradientLayer1 setLocations:@[@0.2,@0.4,@0.6,@0.8,@1]];
        [gradientLayer1 setStartPoint:CGPointMake(0, 0)];
        [gradientLayer1 setEndPoint:CGPointMake(1, 1)];
        [gradientLayer addSublayer:gradientLayer1];
        
        //右下角
        CAGradientLayer *gradientLayer2 =  [CAGradientLayer layer];
        gradientLayer2.frame = CGRectMake(frame.size.width/2, frame.size.height/2, frame.size.width/2, frame.size.height/2);
        [gradientLayer2 setColors:[NSArray arrayWithObjects:(id)[RGB(194,166,121) CGColor],(id)[RGB(209, 172, 120) CGColor],(id)[RGB(190,165,123) CGColor], nil]];
        [gradientLayer2 setLocations:@[@0.33,@0.66,@1]];
        [gradientLayer2 setStartPoint:CGPointMake(0, 0)];
        [gradientLayer2 setEndPoint:CGPointMake(1, 1)];
        [gradientLayer addSublayer:gradientLayer2];
        
        //右上角
        CAGradientLayer *gradientLayer3 =  [CAGradientLayer layer];
        gradientLayer3.frame = CGRectMake(frame.size.width/2-4, -frame.size.height/2-45, frame.size.width/2+4, frame.size.height/2+frame.size.height/2+45);
        [gradientLayer3 setColors:[NSArray arrayWithObjects:(id)[RGB(140, 129, 170) CGColor], (id)[RGB(160, 149, 150) CGColor],(id)[RGB(194,166,121) CGColor],nil]];
        [gradientLayer3 setLocations:@[@0.33,@0.66,@1]];
        [gradientLayer3 setStartPoint:CGPointMake(0, 0)];
        [gradientLayer3 setEndPoint:CGPointMake(1, 1)];
        [gradientLayer addSublayer:gradientLayer3];
        
        
        [gradientLayer setMask:_progressLayer];
        [self.layer addSublayer:gradientLayer];
        
        
        _progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 100)];
        _progressLabel.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        self.progressLabel.textColor = [UIColor colorWithRed:240/255.0 green:198/255.0 blue:83/255.0 alpha:1];
        self.progressLabel.text = @"0%";
        self.progressLabel.textAlignment = NSTextAlignmentCenter;
        self.progressLabel.font = [UIFont systemFontOfSize:35 weight:0.4];
        [bgView addSubview:self.progressLabel];
        
        
        UIImageView *pointImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        pointImg.center = CGPointMake(bgView.gy_w/2, bgView.gy_h/2);
        pointImg.image = [UIImage imageNamed:@"jindupoint"];
        [self addSubview:pointImg];
        self.pointImg = pointImg;
        //改变锚点，使旋转动画与进度条动画一致。（另一种实现，把原点加在另一个视图上，旋转原点点父视图）
        pointImg.layer.anchorPoint = CGPointMake(0.5, 3.7);
        
        [self setProgress:percentag Duration:duration];
        
        
    }
    return self;
}

-(void)setProgress:(CGFloat)percentage Duration:(CFTimeInterval)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    // 这里最好别用语法糖形式,否则动画会有问题
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:percentage];
    _progressLayer.strokeEnd = percentage;
    animation.duration = duration;
    [_progressLayer addAnimation:animation forKey:@"strokeEndAnimation"];
    
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * percentage];
    rotationAnimation.duration = duration;
    rotationAnimation.repeatCount = 1;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    [self.pointImg.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    
    
    // 水波左右滚动
    __weak typeof(self)wself = self;
    void(^callBack)(CGFloat start) = ^(CGFloat start){
        CAKeyframeAnimation *moveAction = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
        //values算是可以调整快慢周期 或写个较大的数循环
        moveAction.values = @[@(start),@(0),@(-start),@(0),@(start)];
        moveAction.duration = duration;
        moveAction.repeatCount = MAXFLOAT;
        [wself.bigImg.layer addAnimation:moveAction forKey:@"waveMoveAnimation"];
        
    };
    
    
    //水波上涨动画（图片从底部斜向滑进来）
    CGFloat avgScore = percentage;
    [UIView animateWithDuration:duration animations:^{
        self.bigImg.gy_y -= self.gy_h * avgScore;
        
        //结束的x值也算可以调整快慢周期
//        self.bigImg.gy_x = -self.gy_w;
        self.bigImg.gy_x = -2*self.gy_w;

    } completion:^(BOOL finished) {
        callBack(self.bigImg.layer.position.x);
    }];
    
    
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                  target:self
                                                selector:@selector(numberAnimation)
                                                userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)numberAnimation
{
    _sumSteps += 0.1;
    float sumSteps = (_percentag/_duration)*_sumSteps;
    if (sumSteps > _percentag) {
        [_timer invalidate];
        _timer = nil;
        return;
    }
    _progressLabel.text = [NSString stringWithFormat:@"%.0f%%",sumSteps*100];
    
    
}







@end
