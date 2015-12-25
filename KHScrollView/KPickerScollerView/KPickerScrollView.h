//
//  KPickerScrollView.h
//  KScrollPicker
//
//  Created by gs on 15/11/16.
//  Copyright © 2015年 KH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KPickerItem,KPickerScrollView;

@protocol KPickerScrollViewDelegate <NSObject>

/**
 
 *  选中（代理方法-可选）
 *
 *  @param menuScollView MLPickerScrollView
 *  @param index         下标
 */
@optional
- (void)pickerScrollView:(KPickerScrollView *)menuScrollView
   didSelecteItemAtIndex:(NSInteger)index;

/**
 *  改变中心位置的Item样式
 *
 *  @param item MLPickerItem
 */
- (void)itemForIndexChange:(KPickerItem *)item;

/**
 *  改变-非-中心位置的Item样式
 *
 *  @param item MLPickerItem
 */
- (void)itemForIndexBack:(KPickerItem *)item;

@end

@protocol KPickerScrollViewDataSource <NSObject>

/**
 *  个数
 *
 *  @param menuScollView MLPickerScrollView
 *
 *  @return 需要展示的item个数
 */
- (NSInteger)numberOfItemAtPickerScrollView:(KPickerScrollView *)pickerScrollView;

/**
 *  用来创建MLPickerItem
 *
 *  @param menuScollView MLPickerScrollView
 *  @param index         位置下标
 *
 *  @return MLPickerItem
 */
- (KPickerItem *)pickerScrollView:(KPickerScrollView *)pickerScrollView
                       itemAtIndex:(NSInteger)index;

@end

@interface KPickerScrollView : UIView

/** 选中下标 */
@property (nonatomic, assign)NSInteger seletedIndex;
/** menu宽 */
@property (nonatomic, assign)CGFloat itemWidth;
/** menu高 */
@property (nonatomic, assign)CGFloat itemHeight;
/** 第一个item X值 */
@property (nonatomic, assign)CGFloat firstItemX;

@property (nonatomic, weak)id<KPickerScrollViewDelegate> delegate;
@property (nonatomic, weak)id<KPickerScrollViewDataSource> dataSource;

- (void)reloadData;
- (void)scollToSelectdIndex:(NSInteger)index;

@end
