//
//  YKRoundedView.m
//  YKRoundedViewDemo
//
//  Created by Yoshiki Kurihara on 2013/10/22.
//  Copyright (c) 2013年 Yoshiki Kurihara. All rights reserved.
//

#import "YKRoundedView.h"
#import <QuartzCore/QuartzCore.h>

@implementation YKRoundedView

- (void)layoutSubviews {
    [super layoutSubviews];

    for (CALayer *layer in self.layer.sublayers) {
        [layer removeFromSuperlayer];
    }
    
    CGRect shadowRect = (CGRect){
        .size = CGSizeMake(self.bounds.size.width, self.bounds.size.height + 0.5f)
    };
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:shadowRect
                                                     byRoundingCorners:self.rectCorner
                                                           cornerRadii:CGSizeMake(5.0f, 5.0f)];
    CAShapeLayer *shadowLayer = [CAShapeLayer layer];
    shadowLayer.path = shadowPath.CGPath;
    shadowLayer.lineWidth = self.lineWidth;
    shadowLayer.strokeColor = self.shadowColor.CGColor;
    
    CGRect subShapeRect = (CGRect){.size=self.bounds.size};
    UIBezierPath *subPath = [UIBezierPath bezierPathWithRoundedRect:subShapeRect
                                                  byRoundingCorners:self.rectCorner
                                                        cornerRadii:CGSizeMake(5.0f, 5.0f)];
    CAShapeLayer *subLayer = [CAShapeLayer layer];
    subLayer.path = subPath.CGPath;
    subLayer.lineWidth = self.lineWidth;
    subLayer.strokeColor = self.strokeColor.CGColor;
    subLayer.fillColor = self.fillColor.CGColor;
    
    [shadowLayer addSublayer:subLayer];
    [self.layer addSublayer:shadowLayer];
}

@end
