//
//  KScroller.m
//  KHScrollView
//
//  Created by gs on 15/11/16.
//  Copyright © 2015年 KH. All rights reserved.
//

#import "KScroller.h"

#define MYWITH                         [[UIScreen mainScreen] bounds].size.width
#define MYHEIGHT                        [[UIScreen mainScreen] bounds].size.height

@implementation KScroller
{
    UIWindow * window ;
    UIButton * lastBtn ;
}
+ (KScroller *) shareKscrollView{
    static KScroller * kScrollView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{kScrollView = [[KScroller alloc] init];});
    return kScrollView;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 44, MYWITH, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:0.5];
    [self addSubview:line];
}

- (void)initWithLeftBtnTitle:(NSString*)leftBtnTitle leftBtnTitleColor:(UIColor*)leftBtnTitleColor title:(NSString*)title titleColor:(UIColor*)titleColor rightBtnTitle:(NSString*)rightBtnTitle rightBtnTitleColor:(UIColor*)rightBtnTitleColor{
    
    if (!self.leftBtn) {
        self.leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MYWITH/3, 44)];
        [self.leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        [self.leftBtn setTitle:leftBtnTitle forState:UIControlStateNormal];
        [self.leftBtn setTitleColor:leftBtnTitleColor forState:UIControlStateNormal];
        self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.leftBtn];
    }
    
    if (!self.rightBtn) {
        self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(MYWITH*2/3, 0, MYWITH/3, 44)];
        [self.rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -50)];
        [self.rightBtn setTitle:rightBtnTitle forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:rightBtnTitleColor forState:UIControlStateNormal];
        self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.rightBtn];
    }
    
    if (!self.titleBtn) {
        self.titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(MYWITH/3, 0, MYWITH/3, 44)];
        [self.titleBtn setTitle:title forState:UIControlStateNormal];
        [self.titleBtn setTitleColor:titleColor forState:UIControlStateNormal];
        self.titleBtn.titleLabel.font = [UIFont fontWithName:@ "Arial Rounded MT Bold"  size:(16)];
        [self addSubview:self.titleBtn];
    }
    
    [self.leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - - - KScrollerViewDataSource
- (void)leftBtnClick:(UIButton *)sender{
    if ([_dataSource respondsToSelector:@selector(KscrollViewleftBtnClick:)]) {
        [_dataSource KscrollViewleftBtnClick:self];
//        [self replayToFirst];
    }
}

- (void)rightBtnClick:(UIButton *)sender{
    if ([_dataSource respondsToSelector:@selector(KscrollViewrightBtnClick:)]) {
        [_dataSource KscrollViewrightBtnClick:self];
    }
}

- (void)titleBtnClick:(UIButton *)sender{
    if ([_dataSource respondsToSelector:@selector(KscrollViewtitleBtnClick:)]) {
        [_dataSource KscrollViewtitleBtnClick:self];
    }
}

@end
