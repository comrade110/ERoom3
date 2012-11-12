//
//  URLUILabel.h
//  ERoom3
//
//  Created by user on 12-11-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class URLUILabel;
@protocol URLLabelDelegate <NSObject>
@required
- (void)urlLabel:(URLUILabel *)myLabel touchesWtihTag:(NSInteger)tag;
@end

@interface URLUILabel : UILabel{

    id<URLLabelDelegate> delegate;

}
@property(nonatomic, assign) id <URLLabelDelegate> delegate;

-(id)initWithFrame:(CGRect)frame;

@end
