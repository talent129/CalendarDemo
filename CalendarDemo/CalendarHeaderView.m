//
//  CalendarHeaderView.m
//  CalendarDemo
//
//  Created by mac on 17/5/4.
//  Copyright © 2017年 cai. All rights reserved.
//

#import "CalendarHeaderView.h"
#import "Masonry.h"
#import "UIColor+hex.h"
#import "common.h"

@implementation CalendarHeaderView

#pragma mark -lazy load
- (UIView *)dateView
{
    if (!_dateView) {
        _dateView = [[UIView alloc] init];
        _dateView.backgroundColor = [UIColor whiteColor];
    }
    return _dateView;
}

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.textColor = [UIColor colorWithHex:0xfc6621];
        _dateLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _dateLabel;
}

- (UIButton *)lastMonthBtn
{
    if (!_lastMonthBtn) {
        _lastMonthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lastMonthBtn setImage:[UIImage imageNamed:@"home__share_back_s"] forState:UIControlStateNormal];
        [_lastMonthBtn setImage:[UIImage imageNamed:@"home__share_back"] forState:UIControlStateHighlighted];
    }
    return _lastMonthBtn;
}

- (UIButton *)nextMonthBtn
{
    if (!_nextMonthBtn) {
        _nextMonthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextMonthBtn setImage:[UIImage imageNamed:@"home__share_go_s"] forState:UIControlStateNormal];
        [_nextMonthBtn setImage:[UIImage imageNamed:@"home__share_go"] forState:UIControlStateHighlighted];
    }
    return _nextMonthBtn;
}

- (UIView *)weekBGView
{
    if (!_weekBGView) {
        _weekBGView = [[UIView alloc] init];
        _weekBGView.backgroundColor = [UIColor colorWithHex:0xf8f8f8];
    }
    return _weekBGView;
}

//初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initHeaderView];
    }
    return self;
}

//create UI
- (void)_initHeaderView
{
    [self addSubview:self.dateView];
    [_dateView addSubview:self.lastMonthBtn];
    [_dateView addSubview:self.nextMonthBtn];
    [_dateView addSubview:self.dateLabel];
    [self addSubview:self.weekBGView];
    
    [_dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.top.trailing.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    __weak typeof(_dateView) weakDateView = _dateView;
    [_lastMonthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(20);
        make.centerY.equalTo(weakDateView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [_nextMonthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-20);
        make.centerY.equalTo(_lastMonthBtn);
        make.size.equalTo(_lastMonthBtn);
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.centerY.equalTo(weakDateView);
    }];
    
    [_weekBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.mas_equalTo(0);
        make.top.equalTo(_dateView.mas_bottom);
        make.height.mas_equalTo(20);
    }];
    
    NSArray *arr = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    for (int i = 0; i < 7; i ++) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor colorWithHex:0x666666];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        label.text = arr[i];
        [_weekBGView addSubview:label];
        
        __weak typeof(_weekBGView) weakWeekBG = _weekBGView;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(i *((SCREEN_WIDTH - 6)/7.0));
            make.centerY.equalTo(weakWeekBG);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 6)/7.0, 18));
        }];
    }
    
}

@end
