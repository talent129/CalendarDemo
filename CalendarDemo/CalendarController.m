//
//  CalendarController.m
//  CalendarDemo
//
//  Created by mac on 17/5/4.
//  Copyright © 2017年 cai. All rights reserved.
//

#import "CalendarController.h"
#import "Masonry.h"
#import "common.h"
#import "UIColor+hex.h"
#import "CalendarCell.h"
#import "CalendarNullCell.h"
#import "CalendarHeaderView.h"

@interface CalendarController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *calendarView;

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, strong) NSDate *todayDate;

@end

@implementation CalendarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    self.title = @"Calendar";
    
    //初始化时间
    self.date = [NSDate date];
    self.todayDate = [NSDate date];//今天
    
    [self createUI];
}

#pragma mark -create UI
- (void)createUI
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    NSInteger itemSum = [self totaldaysInMonth:self.date] + [self firstWeekdayInThisMonth:self.date];
    NSInteger res = itemSum / 7;
    NSInteger resu = itemSum % 7;
    
    NSInteger itemIndex;
    
    if (resu == 0) {
        itemIndex = res;
    }else {
        itemIndex = res + 1;
    }
    
    self.calendarView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH - 6)/7.0 * itemIndex + 0.5 * 4 + 70) collectionViewLayout:flowLayout];
    self.calendarView.scrollEnabled = NO;
    self.calendarView.backgroundColor = [UIColor colorWithHex:0xe0e0e0];
    
    //设置代理
    self.calendarView.delegate = self;
    self.calendarView.dataSource = self;
    [self.view addSubview:self.calendarView];
    
    //注册cell
    [self.calendarView registerClass:[CalendarCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.calendarView registerClass:[CalendarNullCell class] forCellWithReuseIdentifier:@"NilCell"];
    
    [self.calendarView registerClass:[CalendarHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    [self.calendarView reloadData];
}

- (void)setupNextMonth
{
    [self.calendarView removeFromSuperview];
    self.calendarView = nil;
    
    self.date = [self nextMonth:self.date];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    NSInteger itemSum = [self totaldaysInMonth:self.date] + [self firstWeekdayInThisMonth:self.date];
    NSInteger res = itemSum / 7;
    NSInteger resu = itemSum % 7;
    
    NSInteger itemIndex;
    
    if (resu == 0) {
        itemIndex = res;
    }else {
        itemIndex = res + 1;
    }
    
    self.calendarView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH - 6)/7.0 * itemIndex + 2 + 70) collectionViewLayout:flowLayout];
    self.calendarView.scrollEnabled = NO;
    self.calendarView.backgroundColor = [UIColor colorWithHex:0xe0e0e0];
    
    //设置代理
    self.calendarView.delegate = self;
    self.calendarView.dataSource = self;
    [self.view addSubview:self.calendarView];
    
    //注册cell
    [self.calendarView registerClass:[CalendarCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.calendarView registerClass:[CalendarNullCell class] forCellWithReuseIdentifier:@"NilCell"];
    
    [self.calendarView registerClass:[CalendarHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    [self.calendarView reloadData];
}

- (void)setupLastMonth
{
    [self.calendarView removeFromSuperview];
    self.calendarView = nil;

    self.date = [self lastMonth:self.date];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    NSInteger itemSum = [self totaldaysInMonth:self.date] + [self firstWeekdayInThisMonth:self.date];
    NSInteger res = itemSum / 7;
    NSInteger resu = itemSum % 7;
    
    NSInteger itemIndex;
    
    if (resu == 0) {
        itemIndex = res;
    }else {
        itemIndex = res + 1;
    }
    
    self.calendarView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH - 6)/7.0 * itemIndex + 2 + 70) collectionViewLayout:flowLayout];
    self.calendarView.scrollEnabled = NO;
    self.calendarView.backgroundColor = [UIColor colorWithHex:0xe0e0e0];
    
    //设置代理
    self.calendarView.delegate = self;
    self.calendarView.dataSource = self;
    [self.view addSubview:self.calendarView];
    
    //注册cell
    [self.calendarView registerClass:[CalendarCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.calendarView registerClass:[CalendarNullCell class] forCellWithReuseIdentifier:@"NilCell"];
    
    [self.calendarView registerClass:[CalendarHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    [self.calendarView reloadData];
}

#pragma mark -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger itemSum = [self totaldaysInMonth:self.date] + [self firstWeekdayInThisMonth:self.date];
    NSInteger res = itemSum / 7;
    NSInteger resu = itemSum % 7;
    if (resu == 0) {
        return res * 7;
    }else {
        return (res + 1) * 7;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    static NSString *idenNil = @"NilCell";
    
    CalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (indexPath.row < [self firstWeekdayInThisMonth:self.date]) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:idenNil forIndexPath:indexPath];
    }else if (indexPath.row >= ([self totaldaysInMonth:self.date] + [self firstWeekdayInThisMonth:self.date])) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:idenNil forIndexPath:indexPath];
    }else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.dateLabel.text = [[NSString alloc] initWithFormat:@"%ld", indexPath.row - [self firstWeekdayInThisMonth:self.date] + 1];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        NSInteger year = [self year:self.date];
        NSInteger month = [self month:self.date];
        NSString *dayString = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)year, month, indexPath.row - [self firstWeekdayInThisMonth:self.date] + 1];
        NSDate *dayDate = [formatter dateFromString:dayString];
        long long dayLong = [dayDate timeIntervalSince1970];//每月每天时间戳
        
        NSString *todayStr = [formatter stringFromDate:self.todayDate];
        NSDate *todayDate = [formatter dateFromString:todayStr];
        long long todayLong = [todayDate timeIntervalSince1970];//今天时间戳
        
        if (todayLong == dayLong) {//今天
            cell.isToday = YES;
        }
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemWidth = (SCREEN_WIDTH - 6)/7.0;
    return CGSizeMake(itemWidth, itemWidth);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CalendarHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    
    headerView.dateLabel.text = [NSString stringWithFormat:@"%ld年 %ld月", [self year:self.date], [self month:self.date]];
    [headerView.lastMonthBtn addTarget:self action:@selector(setupLastMonth) forControlEvents:UIControlEventTouchUpInside];
    [headerView.nextMonthBtn addTarget:self action:@selector(setupNextMonth) forControlEvents:UIControlEventTouchUpInside];
    return headerView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 71);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", indexPath.row - [self firstWeekdayInThisMonth:self.date] + 1);
    NSLog(@"%ld", indexPath.row);
}

//当月第一天为周几
//0:周日   1:周一  2:周二   3:周三   4:周四  5:周五   6:周六
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *component = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [component setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:component];
    NSUInteger firstWeekDay = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekDay - 1;
}

//每月的总天数
- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInOfMonth.length;
}

#pragma mark - month +/-
//上月
- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

//下月
- (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}


#pragma mark - date get: day-month-year
//日期--天
- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}

//月份
- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

//年份
- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
