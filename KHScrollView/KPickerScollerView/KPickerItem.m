//
//  KPickerItem.m
//  KScrollPicker
//
//  Created by gs on 15/11/16.
//  Copyright © 2015年 KH. All rights reserved.
//

#import "KPickerItem.h"

@implementation KPickerItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTapGesture];
    }
    return self;
}

- (void)addTapGesture
{
    self.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tap];
}

- (void)tap
{
    if (self.PickerItemSelectBlock) {
        self.PickerItemSelectBlock(self.index);
    }
}

// 留给子类调用
- (void)changeSizeOfItem{}
- (void)backSizeOfItem{}

@end
