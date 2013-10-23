//
//  YKRoundedView.m
//  YKRoundedViewDemo
//
//  Created by Yoshiki Kurihara on 2013/10/22.
//  Copyright (c) 2013年 Yoshiki Kurihara. All rights reserved.
//

#import "YKRoundedView.h"
#import <QuartzCore/QuartzCore.h>

#define kYKRoundedViewDefaultLineWidth 1.0f
#define kYKRoundedViewDefaultCornerRadius 8.0f

@implementation YKRoundedView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _showsSeparator = YES;
        _fillColor = [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.0f];
        _strokeColor = [UIColor colorWithRed:0.63f green:0.63f blue:0.63f alpha:0.8f];
        _shadowColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.7f];
        _separatorColor = [UIColor colorWithRed:0.74f green:0.74f blue:0.74f alpha:1.0f];
        _separatorShadowColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat cornerRadius = (_cornerRadius ? _cornerRadius : kYKRoundedViewDefaultCornerRadius);
    CGFloat minX = CGRectGetMinX(self.bounds);
    CGFloat maxX = CGRectGetMaxX(self.bounds);
    CGFloat minY = CGRectGetMinY(self.bounds);
    CGFloat maxY = CGRectGetMaxY(self.bounds);

    if (_position == YKRoundedViewPositionTop) {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, minX, maxY);
        CGPathAddArcToPoint(path, NULL, minX, minY, minX + cornerRadius, minY, cornerRadius);
        CGPathAddArcToPoint(path, NULL, maxX, minY, maxX, minY + cornerRadius, cornerRadius);
        CGPathAddLineToPoint(path, NULL, maxX, maxY);
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = path;
        shapeLayer.fillColor = _fillColor.CGColor;

        CGMutablePathRef linePath = CGPathCreateMutable();
        CGPathMoveToPoint(linePath, NULL, minX, maxY);
        CGPathAddArcToPoint(linePath, NULL, minX, minY, minX + cornerRadius, minY, cornerRadius);
        CGPathAddArcToPoint(linePath, NULL, maxX, minY, maxX, minY + cornerRadius, cornerRadius);
        CGPathAddLineToPoint(linePath, NULL, maxX, maxY);
        
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.path = linePath;
        lineLayer.lineWidth = _lineWidth ? _lineWidth : kYKRoundedViewDefaultLineWidth;
        lineLayer.strokeColor = _strokeColor.CGColor;
        lineLayer.fillColor = [UIColor clearColor].CGColor;

        CGMutablePathRef shadowPath = CGPathCreateMutable();
        CGPathMoveToPoint(shadowPath, NULL, minX, minY + cornerRadius);
        CGPathAddArcToPoint(shadowPath, NULL, minX, minY + 1.0f, minX + cornerRadius, minY + 1.0f, cornerRadius);
        CGPathAddArcToPoint(shadowPath, NULL, maxX, minY + 1.0f, maxX, minY + cornerRadius, cornerRadius);
        
        CAShapeLayer *shadowLayer = [CAShapeLayer layer];
        shadowLayer.path = shadowPath;
        shadowLayer.lineWidth = _lineWidth ? _lineWidth : kYKRoundedViewDefaultLineWidth;
        shadowLayer.strokeColor = _shadowColor.CGColor;
        shadowLayer.fillColor = [UIColor clearColor].CGColor;
        
        [shapeLayer addSublayer:shadowLayer];
        [shapeLayer addSublayer:lineLayer];

        if (_showsSeparator) {
            CGMutablePathRef bottomSeparatorPath = CGPathCreateMutable();
            CGPathMoveToPoint(bottomSeparatorPath, NULL, minX, maxY - 0.5f);
            CGPathAddLineToPoint(bottomSeparatorPath, NULL, maxX, maxY - 0.5f);

            CAShapeLayer *bottomSeparatorLayer = [CAShapeLayer layer];
            bottomSeparatorLayer.path = bottomSeparatorPath;
            bottomSeparatorLayer.lineWidth = _lineWidth ? _lineWidth : kYKRoundedViewDefaultLineWidth;
            bottomSeparatorLayer.strokeColor = _separatorColor.CGColor;
            [shapeLayer addSublayer:bottomSeparatorLayer];
        }
        
        [self.layer insertSublayer:shapeLayer atIndex:0];
    } else if (_position == YKRoundedViewPositionMiddle) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
        shapeLayer.fillColor = (_fillColor ? _fillColor : [UIColor whiteColor]).CGColor;
        
        CGMutablePathRef linePath = CGPathCreateMutable();
        CGPathMoveToPoint(linePath, NULL, minX, maxY);
        CGPathAddLineToPoint(linePath, NULL, minX, minY);
        CGPathMoveToPoint(linePath, NULL, maxX, minY);
        CGPathAddLineToPoint(linePath, NULL, maxX, maxY);

        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.path = linePath;
        lineLayer.lineWidth = _lineWidth ? _lineWidth : kYKRoundedViewDefaultLineWidth;
        lineLayer.strokeColor = _strokeColor.CGColor;
        lineLayer.fillColor = [UIColor clearColor].CGColor;
        
        [shapeLayer addSublayer:lineLayer];


        if (_showsSeparator) {
            CGMutablePathRef topSeparatorPath = CGPathCreateMutable();
            CGPathMoveToPoint(topSeparatorPath, NULL, minX + 0.5f, minY + 0.5f);
            CGPathAddLineToPoint(topSeparatorPath, NULL, maxX - 0.5f, minY + 0.5f);
            
            CAShapeLayer *topSeparatorLayer = [CAShapeLayer layer];
            topSeparatorLayer.path = topSeparatorPath;
            topSeparatorLayer.lineWidth = _lineWidth ? _lineWidth : kYKRoundedViewDefaultLineWidth;
            topSeparatorLayer.strokeColor = _separatorShadowColor.CGColor;
            [shapeLayer addSublayer:topSeparatorLayer];
        
            CGMutablePathRef bottomSeparatorPath = CGPathCreateMutable();
            CGPathMoveToPoint(bottomSeparatorPath, NULL, minX, maxY - 0.5f);
            CGPathAddLineToPoint(bottomSeparatorPath, NULL, maxX, maxY - 0.5f);
            
            CAShapeLayer *bottomSeparatorLayer = [CAShapeLayer layer];
            bottomSeparatorLayer.path = bottomSeparatorPath;
            bottomSeparatorLayer.lineWidth = _lineWidth ? _lineWidth : kYKRoundedViewDefaultLineWidth;
            bottomSeparatorLayer.strokeColor = _separatorColor.CGColor;
            [shapeLayer addSublayer:bottomSeparatorLayer];
        }
        
        [self.layer insertSublayer:shapeLayer atIndex:0];
    } else if (_position == YKRoundedViewPositionBottom) {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, minX, minY);
        CGPathAddArcToPoint(path, NULL, minX, maxY, minX + cornerRadius, maxY, cornerRadius);
        CGPathAddArcToPoint(path, NULL, maxX, maxY, maxX, maxY - cornerRadius, cornerRadius);
        CGPathAddLineToPoint(path, NULL, maxX, minY);
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = path;
        shapeLayer.fillColor = (_fillColor ? _fillColor : [UIColor whiteColor]).CGColor;
        
        CGMutablePathRef linePath = CGPathCreateMutable();
        CGPathMoveToPoint(linePath, NULL, minX, minY);
        CGPathAddArcToPoint(linePath, NULL, minX, maxY, minX + cornerRadius, maxY, cornerRadius);
        CGPathAddArcToPoint(linePath, NULL, maxX, maxY, maxX, maxY - cornerRadius, cornerRadius);
        CGPathAddLineToPoint(linePath, NULL, maxX, minY);
        
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.path = linePath;
        lineLayer.lineWidth = _lineWidth ? _lineWidth : kYKRoundedViewDefaultLineWidth;
        lineLayer.strokeColor = _strokeColor.CGColor;
        lineLayer.fillColor = [UIColor clearColor].CGColor;
        
        CGMutablePathRef shadowPath = CGPathCreateMutable();
        CGPathMoveToPoint(shadowPath, NULL, minX, maxY - cornerRadius);
        CGPathAddArcToPoint(shadowPath, NULL, minX, maxY + 0.5f, minX + cornerRadius, maxY + 0.5f, cornerRadius);
        CGPathAddArcToPoint(shadowPath, NULL, maxX, maxY + 0.5f, maxX, maxY + 0.5f - cornerRadius, cornerRadius);

        CAShapeLayer *shadowLayer = [CAShapeLayer layer];
        shadowLayer.path = shadowPath;
        shadowLayer.lineWidth = _lineWidth ? _lineWidth : kYKRoundedViewDefaultLineWidth;
        shadowLayer.strokeColor = _shadowColor.CGColor;
        shadowLayer.fillColor = [UIColor clearColor].CGColor;

        [shapeLayer addSublayer:shadowLayer];
        [shapeLayer addSublayer:lineLayer];

        if (_showsSeparator) {
            CGMutablePathRef topSeparatorPath = CGPathCreateMutable();
            CGPathMoveToPoint(topSeparatorPath, NULL, minX + 0.5f, minY + 0.5f);
            CGPathAddLineToPoint(topSeparatorPath, NULL, maxX - 0.5f, minY + 0.5f);
            
            CAShapeLayer *topSeparatorLayer = [CAShapeLayer layer];
            topSeparatorLayer.path = topSeparatorPath;
            topSeparatorLayer.lineWidth = _lineWidth ? _lineWidth : kYKRoundedViewDefaultLineWidth;
            topSeparatorLayer.strokeColor = _separatorShadowColor.CGColor;
            [shapeLayer addSublayer:topSeparatorLayer];
        }
        
        [self.layer insertSublayer:shapeLayer atIndex:0];
    } else if (_position == YKRoundedViewPositionSingle) {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, minX, maxY - cornerRadius);
        CGPathAddArcToPoint(path, NULL, minX, minY, minX + cornerRadius, minY, cornerRadius);
        CGPathAddArcToPoint(path, NULL, maxX, minY, maxX, minY + cornerRadius, cornerRadius);
        CGPathAddArcToPoint(path, NULL, maxX, maxY, maxX - cornerRadius, maxY, cornerRadius);
        CGPathAddArcToPoint(path, NULL, minX, maxY, minX, maxY - cornerRadius, cornerRadius);
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = path;
        shapeLayer.fillColor = _fillColor.CGColor;
        
        CGMutablePathRef linePath = CGPathCreateMutable();
        CGPathMoveToPoint(linePath, NULL, minX, maxY - cornerRadius);
        CGPathAddArcToPoint(linePath, NULL, minX, minY, minX + cornerRadius, minY, cornerRadius);
        CGPathAddArcToPoint(linePath, NULL, maxX, minY, maxX, minY + cornerRadius, cornerRadius);
        CGPathAddArcToPoint(linePath, NULL, maxX, maxY, maxX - cornerRadius, maxY, cornerRadius);
        CGPathAddArcToPoint(linePath, NULL, minX, maxY, minX, maxY - cornerRadius, cornerRadius);
        
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.path = linePath;
        lineLayer.lineWidth = _lineWidth ? _lineWidth : kYKRoundedViewDefaultLineWidth;
        lineLayer.strokeColor = _strokeColor.CGColor;
        lineLayer.fillColor = [UIColor clearColor].CGColor;
        
        CGMutablePathRef topShadowPath = CGPathCreateMutable();
        CGPathMoveToPoint(topShadowPath, NULL, minX, minY + cornerRadius);
        CGPathAddArcToPoint(topShadowPath, NULL, minX, minY + 1.0f, minX + cornerRadius, minY + 1.0f, cornerRadius);
        CGPathAddArcToPoint(topShadowPath, NULL, maxX, minY + 1.0f, maxX, minY + cornerRadius, cornerRadius);
        
        CAShapeLayer *topShadowLayer = [CAShapeLayer layer];
        topShadowLayer.path = topShadowPath;
        topShadowLayer.lineWidth = _lineWidth ? _lineWidth : kYKRoundedViewDefaultLineWidth;
        topShadowLayer.strokeColor = _shadowColor.CGColor;
        topShadowLayer.fillColor = [UIColor clearColor].CGColor;
        
        CGMutablePathRef bottomShadowPath = CGPathCreateMutable();
        CGPathMoveToPoint(bottomShadowPath, NULL, minX, maxY - cornerRadius);
        CGPathAddArcToPoint(bottomShadowPath, NULL, minX, maxY + 0.5f, minX + cornerRadius, maxY + 0.5f, cornerRadius);
        CGPathAddArcToPoint(bottomShadowPath, NULL, maxX, maxY + 0.5f, maxX, maxY + 0.5f - cornerRadius, cornerRadius);
        
        CAShapeLayer *bottomShadowLayer = [CAShapeLayer layer];
        bottomShadowLayer.path = bottomShadowPath;
        bottomShadowLayer.lineWidth = _lineWidth ? _lineWidth : kYKRoundedViewDefaultLineWidth;
        bottomShadowLayer.strokeColor = _shadowColor.CGColor;
        bottomShadowLayer.fillColor = [UIColor clearColor].CGColor;
        
        [shapeLayer addSublayer:bottomShadowLayer];
        [shapeLayer addSublayer:topShadowLayer];
        [shapeLayer addSublayer:lineLayer];
        
        [self.layer insertSublayer:shapeLayer atIndex:0];
    }
}

@end
