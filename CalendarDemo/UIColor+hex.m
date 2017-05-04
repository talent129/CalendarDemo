//
//  UIColor+hex.m
//  CalendarDemo
//
//  Created by mac on 17/5/4.
//  Copyright © 2017年 cai. All rights reserved.
//

#import "UIColor+hex.h"

@implementation UIColor (hex)

+ (id) colorWithHex:(unsigned int)hex{
    return [UIColor colorWithHex:hex alpha:1];
}

+ (id) colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha{
    
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hex & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hex & 0xFF)) / 255.0
                           alpha:alpha];
    
}

@end
