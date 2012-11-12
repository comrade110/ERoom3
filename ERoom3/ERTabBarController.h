//
//  ERTabBarController.h
//  ERoom3
//
//  Created by user on 12-10-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ERTabBarView.h"
#import "ClientClass.h"
#import "SOAPXMlParse.h"
#import "ERConfiger.h"


@interface ERTabBarController : UITabBarController<ERTabBarDelegate>{

    ERTabBarView *erTabBarView;
    NSMutableArray *viewArr;
    SoapRequest *request;
}
-(void) hideExistingTabBar;


@end
