//
//  KScroller.h
//  KHScrollView
//
//  Created by gs on 15/11/16.
//  Copyright © 2015年 KH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KScroller;

@protocol KScrollerViewDataSource <NSObject>

@optional

- (void)KscrollViewWillBeginDragging:(KScroller *)scrollView;

- (void)KscrollViewleftBtnClick:(KScroller *)scrollView;

- (void)KscrollViewrightBtnClick:(KScroller *)scrollView;

- (void)KscrollViewtitleBtnClick:(KScroller *)scrollView;

@end

@protocol KScrollerViewDelegate <UIScrollViewDelegate>
@optional
@end


@interface KScroller : UIView

@property (nonatomic, weak) id <KScrollerViewDelegate> delegate;
@property (nonatomic, weak) id <KScrollerViewDataSource> dataSource;
@property (nonatomic, strong) UIButton * leftBtn ;
@property (nonatomic, strong) UIButton* rightBtn ;
@property (nonatomic, strong) UIButton* titleBtn ;
@property (nonatomic, strong) UIScrollView * scrollView ;

+ (KScroller *) shareKscrollView;

- (void)initWithLeftBtnTitle:(NSString*)leftBtnTitle leftBtnTitleColor:(UIColor*)leftBtnTitleColor title:(NSString*)title titleColor:(UIColor*)titleColor rightBtnTitle:(NSString*)rightBtnTitle rightBtnTitleColor:(UIColor*)rightBtnTitleColor;

@end
