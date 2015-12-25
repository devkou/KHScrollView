//
//  ViewController.h
//  KHScrollView
//
//  Created by gs on 15/11/16.
//  Copyright © 2015年 KH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPickerScrollView.h"

@interface ViewController : UIViewController

@property (nonatomic , strong) KPickerScrollView * pickerScollView;
@property (nonatomic , strong) NSMutableArray * data;
@property (nonatomic , assign) NSInteger mySelectIndex;

@end

