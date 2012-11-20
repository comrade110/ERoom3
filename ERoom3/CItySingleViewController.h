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
#import "RelationTableViewController.h"

@interface CItySingleViewController : UIViewController<XLCycleScrollViewDelegate,XLCycleScrollViewDatasource>{

    SDZContTypeField2stringMap *ctArr;
    
    SDZRelationList *relationList;
    
    RelationTableViewController *rtableVC;
    
    UIView *relationView;
}

@property (nonatomic, strong) NSString *conID;
@property (nonatomic, strong) NSString *conTypeID;
@property (nonatomic, strong) UIImage *img;
@property (nonatomic, strong) NSString *descText;

@end
