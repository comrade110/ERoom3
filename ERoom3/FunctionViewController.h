//
//  FunctionViewController.h
//  ERoom3
//
//  Created by user on 12-11-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ERConfiger.h"
#import "ClientClass.h"

@interface FunctionViewController : UIViewController<UIScrollViewDelegate>
{
    UILabel *label;
    
    CGPoint startPoint;
    
    BOOL isTouchSV;
    
    UIScrollView *sv ;
    
    int suoyin;
    
    int seqcount;
    
    NSMutableArray *views;
    
    NSInteger funcNum;
    
    NSArray *funcIcons;
}
@property (nonatomic,assign) NSArray *funcArr;

-(id)initWithSeq:(NSNumber*)index;
@end