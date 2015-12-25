//
//  KPickerItem.h
//  KScrollPicker
//
//  Created by gs on 15/11/16.
//  Copyright © 2015年 KH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPickerItem : UIView

@property (nonatomic, assign)NSInteger index;
@property (nonatomic, assign)CGSize originalSize;
@property (nonatomic, assign)BOOL selected;
/**
 *  选中回调
 */
@property (nonatomic, copy) void(^PickerItemSelectBlock)(NSInteger index);

/**
 *  子类重写实现
 */
- (void)changeSizeOfItem;
- (void)backSizeOfItem;

@end
