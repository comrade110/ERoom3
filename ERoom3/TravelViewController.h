//
//  TravelViewController.h
//  ERoom3
//
//  Created by user on 12-11-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVWebViewController.h"

@interface TravelViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{


    UIPopoverController *cityPop;

    UIButton *citybtn;
    
    NSArray *cityName;
    
    NSArray *cityCode;
    
    NSMutableArray *tuniuData;
    
    NSDictionary *cityDic;
    
    UITableView *tbView;
    
}

@end
