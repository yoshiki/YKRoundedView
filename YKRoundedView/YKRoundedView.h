//
//  YKRoundedView.h
//  YKRoundedViewDemo
//
//  Created by Yoshiki Kurihara on 2013/10/22.
//  Copyright (c) 2013年 Yoshiki Kurihara. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    YKRoundedViewPositionTop = 0,
    YKRoundedViewPositionMiddle,
    YKRoundedViewPositionBottom,
    YKRoundedViewPositionSingle,
} YKRoundedViewPosition;

@interface YKRoundedView : UIView

@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) UIColor *innerShadowColor;
@property (nonatomic, strong) UIColor *outerShadowColor;
@property (nonatomic, strong) UIColor *separatorColor;
@property (nonatomic, strong) UIColor *separatorShadowColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) YKRoundedViewPosition position;
@property (nonatomic, assign) BOOL showsSeparator;

@end
