//
//  NaviViewController.h
//  ERoom3
//
//  Created by user on 12-11-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClientClass.h"
#import "ERConfiger.h"
#import "EGORefreshTableHeaderView.h"
#import "CItySingleViewController.h"
#import "JFDepthView.h"

@interface NaviViewController : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate,JFDepthViewDelegate>{
    
    UIView                    *svbox;
    UIScrollView              *sv;
    NSNumber                  *selBtn;
    int                       topSelTag;
    int                       seltag;
    int                       seltag2;
    int                       typecount;
    NSString                  *conTypeID;
    NSMutableArray            *infoArr;
    UITableView               *tableView;
    int                       curPage;   //  当前页数
    int                       allPage;
    NSString                  *perpage;
    NSString                  *catalogIDs;
    SoapRequest               *infoRequest;
    SoapRequest               *findInfoRequest;
    EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL                      _reloading;
}
@property (nonatomic, strong) NSString *targetID;
@property (nonatomic, strong) JFDepthView *depthView;
@property (nonatomic, strong) CItySingleViewController *singleViewControlle;

@end
