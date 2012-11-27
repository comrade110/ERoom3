//
//  RelationTableViewController.h
//  ERoom3
//
//  Created by user on 12-11-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDZNavigationService.h"
#import "ClientClass.h"
#import "ERConfiger.h"

@interface RelationTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{

    NSMutableArray *list;
    
    UITableView *tableView;
    


}

@property (nonatomic, strong) SDZContentList *rlist;
@property (nonatomic, strong) NSString *conID;
@property (nonatomic, strong) NSString *conTypeID;
@property (nonatomic, strong) NSString *relationID;
@property (nonatomic, strong) NSString *tbName;
@property (nonatomic, strong) UITableView *tableView;


@end
