//
//  ViewController.m
//  KHScrollView
//
//  Created by gs on 15/11/16.
//  Copyright © 2015年 KH. All rights reserved.
//

#import "ViewController.h"
#import "KScroller.h"
#import "MLDemoItem.h"
#import "MLDemoModel.h"

#define kItemW SCREEN_WIDTH/5
#define kItemH 90
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define MLColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define kRGB236 MLColor(236, 73, 73, 1.0)

@interface ViewController ()<KScrollerViewDelegate,KScrollerViewDataSource,KPickerScrollViewDataSource,KPickerScrollViewDelegate>

{
    UIWindow* window ;
    UIView* bgView ;
    KScroller* kscv ;
    UILabel* tipLab;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"show";
    
    UIButton* showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    showBtn.frame = CGRectMake(100, 100, 100, 100);
    showBtn.backgroundColor = [UIColor cyanColor];
    [showBtn addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showBtn];
}

- (void)show:(UIButton*)sneder{
    UIApplication* application = [UIApplication sharedApplication];
    window = [application keyWindow];
    
    bgView = [[UIView alloc] initWithFrame:window.frame];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.6;
    [self.view addSubview:bgView];
    
    UITapGestureRecognizer*singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden:)];
    [bgView addGestureRecognizer:singleTap];
    
    //创建背景框架 以及自定义的弹窗
    kscv = [KScroller shareKscrollView];
    kscv.dataSource = self;
    kscv.delegate = self;
    kscv.backgroundColor = [UIColor whiteColor];
    kscv.frame = CGRectMake(0, window.bounds.size.height, window.bounds.size.width, 0);
    
    //添加自定义的横向滑动pickerView
    [self addKpickerScrollViewToView:kscv];

    
    [self.view addSubview:kscv];
    
    
    [kscv initWithLeftBtnTitle:@"取消小费" leftBtnTitleColor:[UIColor grayColor] title:@"小费" titleColor:[UIColor blackColor] rightBtnTitle:@"确认" rightBtnTitleColor:[UIColor orangeColor]];
    
    [self showKscv];
}

- (void)hidden:(id)sender{
    //bgV 点击触发
}

#pragma mark - - - praviate

- (void)showKscv{
    [UIView animateWithDuration:0.404f delay:0.f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        kscv.frame = CGRectMake(0, window.bounds.size.height - 190, window.bounds.size.width, 190);
    } completion:^(BOOL finished) {
    }];
}

- (void)hiddenKscv{
    [UIView animateWithDuration:0.404f delay:0.f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        kscv.frame = CGRectMake(0, window.bounds.size.height, window.bounds.size.width, 0);
    } completion:^(BOOL finished) {
        [bgView removeFromSuperview];
    }];
}

- (void)addKpickerScrollViewToView:(UIView*)superView{
    // 1.数据源
    if (!_data) {
        _data = [NSMutableArray array];
    }
    NSArray *titleArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",];
    for (int i = 0; i < titleArray.count; i++) {
        MLDemoModel *model = [[MLDemoModel alloc] init];
        model.dicountTitle = [titleArray objectAtIndex:i];
        [_data addObject:model];
    }
    
    // 2.初始化
    if (!_pickerScollView) {
        _pickerScollView = [[KPickerScrollView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, kItemH)];
        _pickerScollView.itemWidth = _pickerScollView.frame.size.width / 5;
        _pickerScollView.itemHeight = kItemH;
        _pickerScollView.firstItemX = (_pickerScollView.frame.size.width - _pickerScollView.itemWidth) * 0.5;
        _pickerScollView.dataSource = self;
        _pickerScollView.delegate = self;
        [superView addSubview:_pickerScollView];
    }

    if (!tipLab) {
        tipLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 45+kItemH, SCREEN_WIDTH, 55)];
        tipLab.font = [UIFont systemFontOfSize:16];
        tipLab.textColor = [UIColor orangeColor];
        tipLab.text = @"1块钱小费耶，让配送员跑的更勤快";
        tipLab.textAlignment = NSTextAlignmentCenter;
        [superView addSubview:tipLab];
    }
    
    
    // 3.刷新数据
    [_pickerScollView reloadData];
    
    // 4.滚动到对应位置
    self.mySelectIndex = 0;
    if (self.mySelectIndex) {
        NSInteger number = 0;
        for (int i = 0; i < _data.count; i++) {
            MLDemoModel *model = [_data objectAtIndex:i];
            if (model.dicountIndex == self.mySelectIndex) {
                number = i;
            }
        }
        _pickerScollView.seletedIndex = number;
        [_pickerScollView scollToSelectdIndex:number];
    }
}

- (void)reloadMyPickerScrollView{
    /******************     延时一下让piker复原动画不展示给用户增强体验性      ********************/
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CGFLOAT_MIN * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.mySelectIndex = 0;
        [_pickerScollView scollToSelectdIndex:self.mySelectIndex];
    });
}

#pragma mark - - - KScrollerViewDelegate

- (void)KscrollViewleftBtnClick:(KScroller *)scrollView{
    
    
#warning 隐藏之前先提交数据
    [self hiddenKscv];
    [self reloadMyPickerScrollView];
}

- (void)KscrollViewrightBtnClick:(KScroller *)scrollView{
    MLDemoModel *model = _data[self.mySelectIndex];
    NSLog(@"select how manay %@",model.dicountTitle);
    
    
    [self hiddenKscv];
    [self reloadMyPickerScrollView];
}

- (void)KscrollViewtitleBtnClick:(KScroller *)scrollView{
    
}

#pragma mark - - - KPickerScrollViewDataSource
- (NSInteger)numberOfItemAtPickerScrollView:(KPickerScrollView *)pickerScrollView
{
    return _data.count;
}

- (KPickerItem *)pickerScrollView:(KPickerScrollView *)pickerScrollView itemAtIndex:(NSInteger)index
{
    // creat
    MLDemoItem *item = [[MLDemoItem alloc] initWithFrame:CGRectMake(0, 0, pickerScrollView.itemWidth, pickerScrollView.itemHeight)];
    
    // assignment
    MLDemoModel *model = [_data objectAtIndex:index];
    model.dicountIndex = index;
    item.title = model.dicountTitle;
    [item setDeselectColorTitle];

    // tap
    item.PickerItemSelectBlock = ^(NSInteger d){

#warning  设定点击选中index
        self.mySelectIndex = d;
        [_pickerScollView scollToSelectdIndex:d];
        
        MLDemoModel *model = [_data objectAtIndex:self.mySelectIndex];
        tipLab.text = [NSString stringWithFormat:@"%@块钱小费耶，让配送员跑的更勤快",model.dicountTitle];
    };
    
    return item;
}

#pragma mark - - - KPickerScrollViewDelegate
- (void)itemForIndexChange:(KPickerItem *)item
{
    [item changeSizeOfItem];
    
#warning  设定滑动选中index
    self.mySelectIndex = item.index;
    MLDemoModel *model = [_data objectAtIndex:self.mySelectIndex];
    tipLab.text = [NSString stringWithFormat:@"%@块钱小费耶，让配送员跑的更勤快",model.dicountTitle];
}

- (void)itemForIndexBack:(KPickerItem *)item
{
    [item backSizeOfItem];
}


@end
