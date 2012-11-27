//
//  CItySingleViewController.h
//  ERoom3
//
//  Created by user on 12-11-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDZNavigationService.h"
#import "ClientClass.h"
#import "ERConfiger.h"
#import "XLCycleScrollView.h"

@interface CItySingleViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{

    SDZContTypeField2stringMap *ctArr;
    
    SDZRelationList *relationList;
    
    
    
    SoapRequest *req;
    
    NSMutableArray *list;
    NSMutableDictionary *dic;
    
    UITableView *tbView;
    UIView *relationView;
    UIView *scrollView;
    UIView *nowView;
    int nowTag;
    NSThread *newThread;
}

@property (nonatomic, strong) NSString *conID;
@property (nonatomic, strong) NSString *conTypeID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *img;
@property (nonatomic, strong) NSString *descText;

@end
