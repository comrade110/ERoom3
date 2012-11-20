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

@interface RelationTableViewController : UITableViewController{

    SDZContentList *list;
    
    UITableView *tableview;


}

@property (nonatomic, strong) SDZContentList *rlist;
@property (nonatomic, strong) NSString *conID;
@property (nonatomic, strong) NSString *conTypeID;
@property (nonatomic, strong) NSString *relationID;
@property (nonatomic, strong) NSString *tbName;


@end
