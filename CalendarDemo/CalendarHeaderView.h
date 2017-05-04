//
//  CalendarHeaderView.h
//  CalendarDemo
//
//  Created by mac on 17/5/4.
//  Copyright © 2017年 cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarHeaderView : UICollectionReusableView

@property (nonatomic, strong) UIView *dateView;
@property (nonatomic, strong) UIButton *lastMonthBtn;
@property (nonatomic, strong) UIButton *nextMonthBtn;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIView *weekBGView;

@end
