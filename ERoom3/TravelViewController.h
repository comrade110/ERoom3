//
//  TravelViewController.h
//  ERoom3
//
//  Created by user on 12-11-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "SVWebViewController.h"
#import "KGTouchXMLRequestOperation.h"
#import "EGORefreshTableHeaderView.h"

@interface TravelViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate,UIScrollViewDelegate>{


    UIPopoverController           *cityPop;
    UIButton                      *citybtn;
    NSString                      *curCity;
    NSNumber                      *curPage;
    NSNumber                      *perPage;
    int                           selTag;
    UIButton                      *curLable;
    NSArray                       *cityName;
    NSArray                       *cityCode;
    NSMutableArray                *tuniuData;
    NSDictionary                  *cityDic;
    KGTouchXMLRequestOperation    *operation;
    UITableView                   *tbView;
    EGORefreshTableHeaderView     *_refreshHeaderView;
	BOOL                          _reloading;
}

@end
