//
//  AppDelegate.h
//  ERoom3
//
//  Created by user on 12-10-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ERTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>{

    ERTabBarController *tabBarController;
    NSMutableArray *array;
    UINavigationController *_navigationController;
}



@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *_navigationController;
@property (strong, nonatomic) ERTabBarController *tabBarController;

@end
