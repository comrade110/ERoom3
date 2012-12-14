//
//  ClientClass.m
//  jiance
//
//  Created by user on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ClientClass.h"

@implementation ClientClass

@synthesize configArr;

static SDZFunctionService *server = nil;
static SDZNavigationService *navServer = nil;
static SDZUserService *userServer = nil;

+(SDZFunctionService *)sharedService{
    
    @synchronized(self){
        if (server == nil) {
            server = [SDZFunctionService service];
        }
    }
    return server;
}
+(SDZNavigationService *)shareNavService{
    
    @synchronized(self){
        if (navServer == nil) {
            navServer = [SDZNavigationService service];
        }
    }
    return navServer;
}
+(SDZUserService *)shareUserService{
    
    @synchronized(self){
        if (userServer == nil) {
            userServer = [SDZUserService service];
        }
    }
    return userServer;
}



@end
