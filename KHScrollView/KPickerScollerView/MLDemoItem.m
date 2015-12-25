//
//  MLDemoItem.m
//  MLPickerScrollView
//
//  Created by MelodyLuo on 15/8/14.
//  Copyright (c) 2015年 MelodyLuo. All rights reserved.
//

#define MYWITH      [[UIScreen mainScreen] bounds].size.width
#define kITEM_WH    44
#define kRGBSelsct [UIColor orangeColor]
#define kRGBdeselect [UIColor lightGrayColor]

#import "MLDemoItem.h"

@implementation MLDemoItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    _discount = [UIButton buttonWithType:UIButtonTypeCustom];
    _discount.enabled = NO;
    _discount.titleLabel.font = [UIFont systemFontOfSize:14];
    CGFloat itemW = kITEM_WH;
    CGFloat itemH = kITEM_WH;
    CGFloat itemX = (self.frame.size.width - itemW)*0.5;
    CGFloat itemY = (self.frame.size.height - itemH) *0.5;
    _discount.frame = CGRectMake(itemX, itemY, itemW, itemH);
    [self addSubview:_discount];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [_discount setTitle:title forState:UIControlStateNormal];
}

- (void)setSelectColorTitle
{
    _discount.layer.borderColor = kRGBSelsct.CGColor;
    [_discount setTitleColor:kRGBSelsct forState:UIControlStateNormal];
}

- (void)setDeselectColorTitle
{
    _discount.layer.borderColor = kRGBdeselect.CGColor;
    [_discount setTitleColor:kRGBdeselect forState:UIControlStateNormal];
}

/**
 *  改变item成选中烦状态. frame变大
 */
- (void)changeSizeOfItem
{
    [self setSelectColorTitle];
    CGFloat itemW = kITEM_WH + kITEM_WH*0.3;
    CGFloat itemH = kITEM_WH + kITEM_WH*0.3;
    CGFloat itemX = (self.frame.size.width - itemW)*0.5;
    CGFloat itemY = (self.frame.size.height - itemH) *0.5;
    _discount.layer.borderWidth = 1.5f;
    _discount.layer.cornerRadius = itemW * 0.5;
    _discount.layer.masksToBounds = YES;
    _discount.frame = CGRectMake(itemX, itemY, itemW, itemH);
    _discount.titleLabel.font = [UIFont systemFontOfSize:25];
}

/**
 *  改变item成非选中状态，frame变小
 */
- (void)backSizeOfItem
{
    [self setDeselectColorTitle];
    _discount.layer.borderWidth = 0.0f;
    _discount.layer.cornerRadius = kITEM_WH * 0.5;
    _discount.layer.masksToBounds = YES;
    CGFloat itemW = kITEM_WH;
    CGFloat itemH = kITEM_WH;
    CGFloat itemX = (self.frame.size.width - itemW)*0.5;
    CGFloat itemY = (self.frame.size.height - itemH) *0.5;
    _discount.frame = CGRectMake(itemX, itemY, itemW, itemH);
    _discount.titleLabel.font = [UIFont systemFontOfSize:14];
}

@end
