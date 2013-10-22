//
//  ViewController.m
//  YKRoundedViewDemo
//
//  Created by Yoshiki Kurihara on 2013/10/22.
//  Copyright (c) 2013年 Yoshiki Kurihara. All rights reserved.
//

#import "ViewController.h"
#import "YKRoundedView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    CGRect appFrame = [UIScreen mainScreen].applicationFrame;

    YKRoundedView *roundedView = [[YKRoundedView alloc] initWithFrame:(CGRect){
        .origin = CGPointMake(10.0f, 100.0f),
        .size = CGSizeMake(CGRectGetWidth(appFrame) - 20.0f, 44.0f),
    }];
    roundedView.rectCorner = UIRectCornerAllCorners;
    roundedView.lineWidth = 1.0f;
    roundedView.strokeColor = [UIColor grayColor];
    roundedView.fillColor = [UIColor whiteColor];
    roundedView.shadowColor = [UIColor whiteColor];
    [self.view addSubview:roundedView];
}

@end
