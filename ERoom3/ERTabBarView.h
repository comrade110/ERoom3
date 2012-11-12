//
//  ERTabBarView.h
//  ERoom3
//
//  Created by user on 12-10-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ERTabBarDelegate <NSObject>

-(void)tabWasSelected:(NSInteger)index;

@end

@interface ERTabBarView : UIView{

    NSObject<ERTabBarDelegate> *delegate;
    
    UIButton *selectedButton;

}
@property (nonatomic, strong) NSObject<ERTabBarDelegate> *delegate;

@property (nonatomic, strong) UIButton *selectedButton;


-(void)touchButton:(id)sender;

@end
