//
//  ViewController.m
//  GYWaveCirCleProgress
//
//  Created by ronmei on 16/9/1.
//  Copyright © 2016年 gaoyu. All rights reserved.
//

#import "ViewController.h"
#import "GYWaveCircleProgressView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    GYWaveCircleProgressView *progressView = [[GYWaveCircleProgressView alloc] initWithFrame:CGRectMake(0, 0, 200, 200) setProgress:0.75 Duration:3.5];
    progressView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    [self.view addSubview:progressView];
}



@end
