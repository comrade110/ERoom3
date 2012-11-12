//
//  URLUILabel.m
//  ERoom3
//
//  Created by user on 12-11-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "URLUILabel.h"

#define FONTSIZE 13
#define COLOR(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

@implementation URLUILabel

@synthesize delegate=_delegate;

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame])
    {
        [self setLineBreakMode:UILineBreakModeWordWrap|UILineBreakModeTailTruncation];
        [self setFont:[UIFont systemFontOfSize:FONTSIZE]];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTextColor:COLOR(59,136,195,1.0)];
        [self setUserInteractionEnabled:YES];
        [self setNumberOfLines:0];
    }
    return self;
}

// 点击该label变色
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setTextColor:[UIColor yellowColor]];
}
// 还原label颜色,获取手指离开屏幕时的坐标点, 在label范围内的话就可以触发自定义的操作
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setTextColor:COLOR(59,136,195,1.0)];
    UITouch *touch = [touches anyObject];
    CGPoint points = [touch locationInView:self];
    if (points.x >= self.frame.origin.x && points.y >= self.frame.origin.x && points.x <= self.frame.size.width && points.y <= self.frame.size.height)
    {
        [_delegate urlLabel:self touchesWtihTag:self.tag];
    }
}

@end
