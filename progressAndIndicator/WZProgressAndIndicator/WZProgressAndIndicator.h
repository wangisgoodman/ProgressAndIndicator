//
//  WZProgressAndIndicator.h
//  progressAndIndicator
//
//  Created by zhwz on 2017/4/17.
//  Copyright © 2017年 zhwz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,WZProgressAndIndicatorType) {
    WZProgressAndIndicatorTypeProgress = 1,
    WZProgressAndIndicatorTypeIndicator
};

@interface WZProgressAndIndicator : UIView

- (instancetype)initWithFrame:(CGRect)frame andType:(WZProgressAndIndicatorType)type;

- (void)changeBackGroundColor:(UIColor*)baseColor andLineWidth:(float)width;

- (void)changeProgressColor:(UIColor*)color;

/* indicator  0~~~1 */
- (void)changeProgressLengthForIndicatorStart:(float)start andEnd:(float)end;

- (void)setEveryAnimationTime:(float)time;

/* progress 0~~~1*/
- (void)changeProgressValueForProgressType:(float)value;


@end
