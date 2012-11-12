//
//  ERConfiger.h
//  ERoom3
//
//  Created by user on 12-10-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERConfiger : NSObject

@property(nonatomic,retain) NSString *sessionID;
@property(nonatomic,retain) NSMutableArray *imgURLArr;
@property(nonatomic,retain) NSMutableArray *lightimgURLArr;
@property(nonatomic,retain) NSArray *configArr;
@property(nonatomic,retain) NSString *ip;

+(ERConfiger*)shareERConfiger;

@end
