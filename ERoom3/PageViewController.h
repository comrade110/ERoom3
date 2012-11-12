//
//  PageViewController.h
//  ERoom3
//
//  Created by user on 12-11-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFOpenFlowView.h"
#import "ERConfiger.h"

@interface PageViewController : UIViewController<AFOpenFlowViewDataSource,AFOpenFlowViewDelegate>{

    NSArray *coverImageData;
    NSArray *coverImage;
    
}
- (id)initWithPageSeq:(int)seq andBtnTag:(int)index;

@end
