//
//  ERTabBarView.m
//  ERoom3
//
//  Created by user on 12-10-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ERTabBarView.h"
#import "ERConfiger.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "FunctionViewController.h"

@implementation ERTabBarView

@synthesize delegate;
@synthesize selectedButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 660, 1024, 108)];
    if (self) {
    }
    return self;
}





-(void) touchButton:(id)sender {
    
    
    if( delegate != nil && [delegate respondsToSelector:@selector(tabWasSelected:)]) {

        if (selectedButton) {
            UIImage *cached = [[SDImageCache sharedImageCache] imageFromKey:[NSString stringWithFormat:@"menu%d",selectedButton.tag]];
            if (cached) {
                
                [selectedButton setBackgroundImage:cached forState:UIControlStateNormal];
            
            }else{ 
                
                NSLog(@"ddd");
            } 

            
        }
        
        selectedButton = (UIButton*)sender;
        UIImage *cachedImage = [[SDImageCache sharedImageCache] imageFromKey:[NSString stringWithFormat:@"menulight%d",selectedButton.tag]];
        if (cachedImage) {
            [selectedButton setBackgroundImage:cachedImage forState:UIControlStateNormal];
            
        }else{ 
            
            NSLog(@"????????????");
        } 

        [delegate tabWasSelected:selectedButton.tag-10];
    }
}
@end
