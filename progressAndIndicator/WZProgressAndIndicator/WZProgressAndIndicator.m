//
//  WZProgressAndIndicator.m
//  progressAndIndicator
//
//  Created by zhwz on 2017/4/17.
//  Copyright © 2017年 zhwz. All rights reserved.
//

#import "WZProgressAndIndicator.h"

@interface WZProgressAndIndicator()

@property (nonatomic, strong) CAShapeLayer *baseLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic) WZProgressAndIndicatorType type;

@property (nonatomic) float indicatorEveryTime;

@end

@implementation WZProgressAndIndicator

- (instancetype)initWithFrame:(CGRect)frame andType:(WZProgressAndIndicatorType)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addBaseAndProgressLayers];
        self.type = type?:WZProgressAndIndicatorTypeIndicator;
        self.indicatorEveryTime = 0.f;
    }
    return self;
}

- (void)setType:(WZProgressAndIndicatorType)type {
    _type = type;
    if (_type == WZProgressAndIndicatorTypeIndicator) {
        _progressLayer.strokeStart = 0.f;
        _progressLayer.strokeEnd = 0.75f;
    } else {
        _progressLayer.strokeStart = _progressLayer.strokeEnd = 0.f;
    }
}

- (void)addBaseAndProgressLayers {
    
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    //圆形背景layer ，默认是灰色，考虑到是背景，所以只给修改 宽度 和 颜色 的方法
    _baseLayer = [CAShapeLayer layer];
    _baseLayer.frame = self.bounds;
    _baseLayer.position = self.center;
    _baseLayer.fillColor = [UIColor clearColor].CGColor;
    _baseLayer.lineWidth = 2.f;
    _baseLayer.path = circle.CGPath;
    _baseLayer.strokeColor = [UIColor grayColor].CGColor;
    _baseLayer.strokeStart = 0.f;
    _baseLayer.strokeEnd = 1.f;
    [self.layer addSublayer:_baseLayer];
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = self.bounds;
    _progressLayer.position = self.center;
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    _progressLayer.lineWidth = 2.f;
    _progressLayer.path = circle.CGPath;
    _progressLayer.strokeColor = [UIColor redColor].CGColor;
    [self.layer  addSublayer:_progressLayer];
    
}

- (void)changeBackGroundColor:(UIColor*)baseColor andLineWidth:(float)width {
    if (baseColor) {
        _baseLayer.strokeColor = baseColor.CGColor;
    }
    _baseLayer.lineWidth = _progressLayer.lineWidth = (width >0)?width:2.f;
}

- (void)changeProgressColor:(UIColor*)color {
    _progressLayer.strokeColor = color.CGColor;
}
/*
    分别针对两种模式的方法了
 */

- (void)changeProgressLengthForIndicatorStart:(float)start andEnd:(float)end {
    //  start 必须小于 end
    if (start == end) {
        start = end = 2.f;
    }
    if (start > end) {
        float temp = end;
        end = start;
        start = temp;
    }
    
    if (_type == WZProgressAndIndicatorTypeIndicator) {
         _progressLayer.strokeStart = (start > 1 || start < 0) ? 0 : start;
        _progressLayer.strokeEnd = (end > 1 || end < 0) ? 0.75 : end;
    }
}
/*
    indicator 是有动画的  要有个启动动画
 */
- (void)startIndicatorAnimation {
    if (_type == WZProgressAndIndicatorTypeIndicator) {
        CABasicAnimation *tempAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        tempAni.toValue = [NSNumber numberWithFloat:M_PI*2];
        tempAni.duration = (_indicatorEveryTime == 0.f) ? 1.5f : _indicatorEveryTime;
        tempAni.repeatCount = MAXFLOAT;
        [_progressLayer addAnimation:tempAni forKey:@"ratateAni"];
    }
}
//每一圈的时间
- (void)setEveryAnimationTime:(float)time {
    if (time > 0) {
        _indicatorEveryTime = time;
        [_progressLayer removeAnimationForKey:@"ratateAni"];
        [self startIndicatorAnimation];
    }
}

/*
      value 值  0 ~ 1
 */
- (void)changeProgressValueForProgressType:(float)value {
    if (_type == WZProgressAndIndicatorTypeProgress) {
         _progressLayer.strokeEnd = value;
    }
}

@end

