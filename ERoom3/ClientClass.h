//
//  ClientClass.h
//  jiance
//
//  Created by user on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDZFunctionService.h"



@interface ClientClass : NSObject

@property(nonatomic,retain) NSArray *configArr;

+(SDZFunctionService *)sharedService;
@end
