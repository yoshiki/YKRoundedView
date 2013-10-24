//
//  ViewController.m
//  YKRoundedViewDemo
//
//  Created by Yoshiki Kurihara on 2013/10/22.
//  Copyright (c) 2013年 Yoshiki Kurihara. All rights reserved.
//

#import "ViewController.h"
#import "YKRoundedView.h"
#import "TableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.77f green:0.78f blue:0.82f alpha:1.0f];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Native Table Sample"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(show:)];
    
    CGRect appFrame = [UIScreen mainScreen].applicationFrame;

    YKRoundedView *roundedView0 = [[YKRoundedView alloc] initWithFrame:(CGRect){
        .origin = CGPointMake(10.0f, 10.0f),
        .size = CGSizeMake(CGRectGetWidth(appFrame) - 20.0f, 44.0f),
    }];
    roundedView0.showsSeparator = YES;
    roundedView0.position = YKRoundedViewPositionTop;
    [self.view addSubview:roundedView0];

    YKRoundedView *roundedView1 = [[YKRoundedView alloc] initWithFrame:(CGRect){
        .origin = CGPointMake(10.0f, CGRectGetMaxY(roundedView0.frame)),
        .size = CGSizeMake(CGRectGetWidth(appFrame) - 20.0f, 44.0f),
    }];
    roundedView1.showsSeparator = YES;
    roundedView1.position = YKRoundedViewPositionMiddle;
    [self.view addSubview:roundedView1];

    YKRoundedView *roundedView2 = [[YKRoundedView alloc] initWithFrame:(CGRect){
        .origin = CGPointMake(10.0f, CGRectGetMaxY(roundedView1.frame)),
        .size = CGSizeMake(CGRectGetWidth(appFrame) - 20.0f, 44.0f),
    }];
    roundedView2.showsSeparator = YES;
    roundedView2.position = YKRoundedViewPositionBottom;
    [self.view addSubview:roundedView2];

    YKRoundedView *roundedView3 = [[YKRoundedView alloc] initWithFrame:(CGRect){
        .origin = CGPointMake(10.0f, CGRectGetMaxY(roundedView2.frame) + 10.0f),
        .size = CGSizeMake(CGRectGetWidth(appFrame) - 20.0f, 44.0f),
    }];
    roundedView3.position = YKRoundedViewPositionSingle;
    [self.view addSubview:roundedView3];
}

- (void)show:(id)sender {
    TableViewController *vc = [[TableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
