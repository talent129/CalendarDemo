//
//  ViewController.m
//  CalendarDemo
//
//  Created by mac on 17/5/4.
//  Copyright © 2017年 cai. All rights reserved.
//

#import "ViewController.h"
#import "common.h"
#import "Masonry.h"
#import "CalendarController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *calendarBtn;

@end

@implementation ViewController

#pragma mark -lazy load
- (UIButton *)calendarBtn
{
    if (!_calendarBtn) {
        _calendarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _calendarBtn.backgroundColor = [UIColor purpleColor];
        _calendarBtn.layer.cornerRadius = 8;
        [_calendarBtn setTitle:@"日历" forState:UIControlStateNormal];
        [_calendarBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _calendarBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_calendarBtn addTarget:self action:@selector(calendarBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _calendarBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.title = @"VC";
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self createUI];
    
}

#pragma mark -create UI
- (void)createUI
{
    [self.view addSubview:self.calendarBtn];
    
    [_calendarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.top.mas_equalTo(100);
        make.trailing.mas_equalTo(-10);
        make.height.mas_equalTo(50);
    }];
    
    
}

#pragma mark -点击事件
- (void)calendarBtnAction
{
    NSLog(@"点击了日历按钮");
    
    CalendarController *calendarVC = [[CalendarController alloc] init];
    [self.navigationController pushViewController:calendarVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
