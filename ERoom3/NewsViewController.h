//
//  NewsViewController.h
//  ERoom3
//
//  Created by user on 12-11-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ERConfiger.h"
#import "SOAPXMlParse.h"
#import "EGORefreshTableHeaderView.h"
#import "URLUILabel.h"

@interface NewsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate,UIScrollViewDelegate,URLLabelDelegate>{

    NSArray *newsArr;
    NSArray *perPageArr;
    NSMutableData *receivedData;
    UITableView *tableView;
    NSMutableArray *linkArr;
    EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL _reloading;
    NSInteger curCount;
}

-(id)initWithNewsSeq:(int)seq andBtntag:(int)index;

@end
