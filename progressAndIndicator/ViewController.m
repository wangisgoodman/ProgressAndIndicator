//
//  ViewController.m
//  progressAndIndicator
//
//  Created by zhwz on 2017/4/17.
//  Copyright © 2017年 zhwz. All rights reserved.
//

#import "ViewController.h"
#import "WZProgressAndIndicator.h"

@interface ViewController ()
@property (nonatomic, strong) WZProgressAndIndicator *progressView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WZProgressAndIndicator * custoView = [[WZProgressAndIndicator alloc] initWithFrame:CGRectMake(100, 100, 100, 100) andType:WZProgressAndIndicatorTypeIndicator];
    [custoView setEveryAnimationTime:1.f];
    [custoView changeBackGroundColor:nil andLineWidth:5];
    [custoView changeProgressColor:[UIColor yellowColor]];
    [custoView changeProgressLengthForIndicatorStart:0.5 andEnd:0.7];
    [self.view addSubview:custoView];

    _progressView = [[WZProgressAndIndicator alloc] initWithFrame:CGRectMake(100, 250, 100, 100) andType:WZProgressAndIndicatorTypeProgress];
    [_progressView changeBackGroundColor:nil andLineWidth:5];
    [self.view addSubview:_progressView];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 40, 300, 40)];
    [slider addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}

- (void)change:(UISlider*)slider {
    NSLog(@"%f",slider.value);
    [_progressView changeProgressValueForProgressType:slider.value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
