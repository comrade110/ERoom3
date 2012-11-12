//
//  ERConfiger.m
//  ERoom3
//
//  Created by user on 12-10-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ERConfiger.h"

@implementation ERConfiger

@synthesize sessionID,imgURLArr,lightimgURLArr,configArr,ip;

static ERConfiger *erConfiger = nil;

+(ERConfiger*)shareERConfiger{
    @synchronized(self){
        if (erConfiger==nil) {  
            
            erConfiger = [[ERConfiger alloc] init];
        }
    }
    
    return erConfiger;
}

@end
