//
//  CalendarCell.h
//  CalendarDemo
//
//  Created by mac on 17/5/4.
//  Copyright © 2017年 cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, assign) BOOL isToday;//是否是今天 YES:是  NO:不是

@end
