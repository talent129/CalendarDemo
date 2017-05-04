//
//  CalendarCell.m
//  CalendarDemo
//
//  Created by mac on 17/5/4.
//  Copyright © 2017年 cai. All rights reserved.
//

#import "CalendarCell.h"
#import "Masonry.h"
#import "UIColor+hex.h"

@interface CalendarCell ()

@property (nonatomic, strong) UILabel *todayLabel;

@end

@implementation CalendarCell

#pragma mark -lazy load
- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.textColor = [UIColor grayColor];
        _dateLabel.font = [UIFont systemFontOfSize:13];
    }
    return _dateLabel;
}

- (UILabel *)todayLabel
{
    if (!_todayLabel) {
        _todayLabel = [[UILabel alloc] init];
        _todayLabel.text = @"今天";
        _todayLabel.textColor = [UIColor colorWithHex:0xfc6621];
        _todayLabel.textAlignment = NSTextAlignmentCenter;
        _todayLabel.font = [UIFont systemFontOfSize:16];
    }
    return _todayLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.dateLabel];
        
        __weak typeof(self) weakSelf = self;
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.contentView);
            make.top.mas_equalTo(8);
        }];
    }
    return self;
}

#pragma mark -重新布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.isToday == YES) {
        [self.dateLabel removeFromSuperview];
        self.dateLabel = nil;
        
        [self.contentView addSubview:self.todayLabel];
        
        __weak typeof(self) weakSelf = self;
        [_todayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf);
        }];
    }
}

@end
