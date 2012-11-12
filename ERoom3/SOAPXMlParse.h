//
//  SOAPXMlParse.h
//  jiance
//
//  Created by user on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouchXML.h"

@interface SOAPXMlParse : NSObject{

    NSMutableDictionary *objectAttributes;
    
}

- (NSArray *) parseDire:(CXMLDocument *)document nodeName:(NSString*)nodePathName;


- (NSArray *) parseDire2:(CXMLDocument *)document nodeName:(NSString*)nodePathName;

- (NSArray *) parseRoot:(CXMLDocument *) document nodeName:(NSString*) nodePathName;

@end
