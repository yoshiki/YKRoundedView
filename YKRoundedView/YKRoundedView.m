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
        self.backgroundColor = [UIColor clearColor];

        _showsSeparator = NO;
        _lineWidth = kYKRoundedViewDefaultLineWidth;
        _fillColor = [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.0f];
        _strokeColor = [UIColor colorWithRed:0.63f green:0.63f blue:0.63f alpha:0.8f];
        _innerShadowColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.1f];
        _outerShadowColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.1f];
        _separatorColor = [UIColor colorWithRed:0.74f green:0.74f blue:0.74f alpha:1.0f];
        _separatorShadowColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    CGFloat cornerRadius = (_cornerRadius ? _cornerRadius : kYKRoundedViewDefaultCornerRadius);

    // for smooth stroke( http://stackoverflow.com/a/2181479 )
    CGRect lineRect = CGRectInset(self.bounds, _lineWidth/2, _lineWidth/2);
    CGFloat minX = CGRectGetMinX(lineRect);
    //CGFloat midX = CGRectGetMidX(lineRect);
    CGFloat maxX = CGRectGetMaxX(lineRect);
    CGFloat minY = CGRectGetMinY(lineRect);
    CGFloat midY = CGRectGetMidY(lineRect);
    CGFloat maxY = CGRectGetMaxY(lineRect);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, self.bounds);

    if (_position == YKRoundedViewPositionTop) {
        CGMutablePathRef linePath = CGPathCreateMutable();
        CGPathMoveToPoint(linePath, NULL, minX, maxY + _lineWidth/2);
        CGPathAddArcToPoint(linePath, NULL, minX, minY, minX + cornerRadius, minY, cornerRadius);
        CGPathAddArcToPoint(linePath, NULL, maxX, minY, maxX, minY + cornerRadius, cornerRadius);
        CGPathAddLineToPoint(linePath, NULL, maxX, maxY + _lineWidth/2);

        CGContextSaveGState(ctx);
        CGContextAddPath(ctx, linePath);
        CGContextSetFillColorWithColor(ctx, _fillColor.CGColor);
        CGContextSetStrokeColorWithColor(ctx, _strokeColor.CGColor);
        CGContextSetLineCap(ctx, kCGLineCapSquare);
        CGContextSetLineWidth(ctx, _lineWidth);
        CGContextSetShadowWithColor(ctx, CGSizeMake(0.0f, 1.0f), 0.5f, _innerShadowColor.CGColor);
        CGContextDrawPath(ctx, kCGPathFillStroke);
        CGContextRestoreGState(ctx);
    } else if (_position == YKRoundedViewPositionMiddle) {
        CGMutablePathRef shapePath = CGPathCreateMutable();
        CGPathMoveToPoint(shapePath, NULL, minX, maxY + _lineWidth/2);
        CGPathAddLineToPoint(shapePath, NULL, minX, minY - _lineWidth/2);
        CGPathAddLineToPoint(shapePath, NULL, maxX, minY - _lineWidth/2);
        CGPathAddLineToPoint(shapePath, NULL, maxX, maxY + _lineWidth/2);
        
        CGContextSaveGState(ctx);
        CGContextAddPath(ctx, shapePath);
        CGContextSetFillColorWithColor(ctx, _fillColor.CGColor);
        CGContextDrawPath(ctx, kCGPathFill);
        CGContextRestoreGState(ctx);

        CGMutablePathRef linePath = CGPathCreateMutable();
        CGPathMoveToPoint(linePath, NULL, minX, maxY);
        CGPathAddLineToPoint(linePath, NULL, minX, minY);
        CGPathMoveToPoint(linePath, NULL, maxX, minY);
        CGPathAddLineToPoint(linePath, NULL, maxX, maxY);
        
        CGContextSaveGState(ctx);
        CGContextAddPath(ctx, linePath);
        CGContextSetStrokeColorWithColor(ctx, _strokeColor.CGColor);
        CGContextSetLineCap(ctx, kCGLineCapSquare);
        CGContextSetLineWidth(ctx, _lineWidth);
        CGContextDrawPath(ctx, kCGPathStroke);
        CGContextRestoreGState(ctx);
        
        if (_showsSeparator) {
            CGMutablePathRef lowerSeparatorPath = CGPathCreateMutable();
            CGPathMoveToPoint(lowerSeparatorPath, NULL, minX + _lineWidth, minY + _lineWidth);
            CGPathAddLineToPoint(lowerSeparatorPath, NULL, maxX - _lineWidth, minY + _lineWidth);
            
            CGContextSaveGState(ctx);
            CGContextAddPath(ctx, lowerSeparatorPath);
            CGContextSetStrokeColorWithColor(ctx, _separatorShadowColor.CGColor);
            CGContextSetLineWidth(ctx, (_lineWidth ? _lineWidth : kYKRoundedViewDefaultLineWidth));
            CGContextDrawPath(ctx, kCGPathStroke);
            CGContextRestoreGState(ctx);

            CGMutablePathRef upperSeparatorPath = CGPathCreateMutable();
            CGPathMoveToPoint(upperSeparatorPath, NULL, minX + _lineWidth/2, minY);
            CGPathAddLineToPoint(upperSeparatorPath, NULL, maxX - _lineWidth/2, minY);
            
            CGContextSaveGState(ctx);
            CGContextAddPath(ctx, upperSeparatorPath);
            CGContextSetStrokeColorWithColor(ctx, _separatorColor.CGColor);
            CGContextSetLineWidth(ctx, (_lineWidth ? _lineWidth : kYKRoundedViewDefaultLineWidth));
            CGContextDrawPath(ctx, kCGPathStroke);
            CGContextRestoreGState(ctx);
        }
    } else if (_position == YKRoundedViewPositionBottom) {
        CGMutablePathRef linePath = CGPathCreateMutable();
        CGPathMoveToPoint(linePath, NULL, minX, minY - _lineWidth/2);
        CGPathAddArcToPoint(linePath, NULL, minX, maxY - _lineWidth/2, minX + cornerRadius, maxY - _lineWidth/2, cornerRadius);
        CGPathAddArcToPoint(linePath, NULL, maxX, maxY - _lineWidth/2, maxX, maxY - _lineWidth/2 - cornerRadius, cornerRadius);
        CGPathAddLineToPoint(linePath, NULL, maxX, minY - _lineWidth/2);
        
        CGContextSaveGState(ctx);

        CGContextAddPath(ctx, linePath);
        CGContextSetFillColorWithColor(ctx, _fillColor.CGColor);
        CGContextSetStrokeColorWithColor(ctx, _strokeColor.CGColor);
        CGContextSetLineCap(ctx, kCGLineCapSquare);
        CGContextSetLineWidth(ctx, _lineWidth);
        CGContextSetShadowWithColor(ctx, CGSizeMake(0.0f, 1.0f), 0.5f, _outerShadowColor.CGColor);
        CGContextDrawPath(ctx, kCGPathFillStroke);
        CGContextRestoreGState(ctx);
        
        if (_showsSeparator) {
            CGMutablePathRef lowerSeparatorPath = CGPathCreateMutable();
            CGPathMoveToPoint(lowerSeparatorPath, NULL, minX + _lineWidth, minY + _lineWidth);
            CGPathAddLineToPoint(lowerSeparatorPath, NULL, maxX - _lineWidth, minY + _lineWidth);
            
            CGContextSaveGState(ctx);
            CGContextAddPath(ctx, lowerSeparatorPath);
            CGContextSetStrokeColorWithColor(ctx, _separatorShadowColor.CGColor);
            CGContextSetLineWidth(ctx, (_lineWidth ? _lineWidth : kYKRoundedViewDefaultLineWidth));
            CGContextDrawPath(ctx, kCGPathStroke);
            CGContextRestoreGState(ctx);
            
            CGMutablePathRef upperSeparatorPath = CGPathCreateMutable();
            CGPathMoveToPoint(upperSeparatorPath, NULL, minX + _lineWidth/2, minY);
            CGPathAddLineToPoint(upperSeparatorPath, NULL, maxX - _lineWidth/2, minY);
            
            CGContextSaveGState(ctx);
            CGContextAddPath(ctx, upperSeparatorPath);
            CGContextSetStrokeColorWithColor(ctx, _separatorColor.CGColor);
            CGContextSetLineWidth(ctx, (_lineWidth ? _lineWidth : kYKRoundedViewDefaultLineWidth));
            CGContextDrawPath(ctx, kCGPathStroke);
            CGContextRestoreGState(ctx);
        }
    } else if (_position == YKRoundedViewPositionSingle) {
        CGMutablePathRef upperLinePath = CGPathCreateMutable();
        CGPathMoveToPoint(upperLinePath, NULL, minX, midY);
        CGPathAddArcToPoint(upperLinePath, NULL, minX, minY, minX + cornerRadius, minY, cornerRadius);
        CGPathAddArcToPoint(upperLinePath, NULL, maxX, minY, maxX, midY, cornerRadius);
        CGPathAddLineToPoint(upperLinePath, NULL, maxX, midY);
        
        CGContextSaveGState(ctx);
        CGContextAddPath(ctx, upperLinePath);
        CGContextSetFillColorWithColor(ctx, _fillColor.CGColor);
        CGContextSetStrokeColorWithColor(ctx, _strokeColor.CGColor);
        CGContextSetLineCap(ctx, kCGLineCapSquare);
        CGContextSetLineWidth(ctx, _lineWidth);
        CGContextSetShadowWithColor(ctx, CGSizeMake(0.0f, 1.0f), 0.5f, _innerShadowColor.CGColor);
        CGContextDrawPath(ctx, kCGPathFillStroke);
        CGContextRestoreGState(ctx);

        CGMutablePathRef lowerLinePath = CGPathCreateMutable();
        CGPathMoveToPoint(lowerLinePath, NULL, minX, midY);
        CGPathAddArcToPoint(lowerLinePath, NULL, minX, maxY, minX + cornerRadius, maxY, cornerRadius);
        CGPathAddArcToPoint(lowerLinePath, NULL, maxX, maxY, maxX, midY, cornerRadius);
        CGPathAddLineToPoint(lowerLinePath, NULL, maxX, midY);
        
        CGContextSaveGState(ctx);
        CGContextAddPath(ctx, lowerLinePath);
        CGContextSetFillColorWithColor(ctx, _fillColor.CGColor);
        CGContextSetStrokeColorWithColor(ctx, _strokeColor.CGColor);
        CGContextSetLineCap(ctx, kCGLineCapSquare);
        CGContextSetLineWidth(ctx, _lineWidth);
        CGContextSetShadowWithColor(ctx, CGSizeMake(0.0f, 1.0f), 0.5f, _outerShadowColor.CGColor);
        CGContextDrawPath(ctx, kCGPathFillStroke);
        CGContextRestoreGState(ctx);
    }
}

@end
