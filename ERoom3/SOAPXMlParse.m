//
//  SOAPXMlParse.m
//  jiance
//
//  Created by user on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SOAPXMlParse.h"

@implementation SOAPXMlParse

- (NSArray *) parseDire:(CXMLDocument *) document nodeName:(NSString*) nodePathName
{
    NSMutableArray *ar=[[NSMutableArray alloc] init];
    
    NSArray *nodes=nil;
    nodes=[document nodesForXPath:nodePathName error:nil];
    NSString *strValue;
    NSString *strName;
    
    for (CXMLElement *node in nodes) {
        NSMutableDictionary *object=[[NSMutableDictionary alloc] init];
        
        // process to set attributes of object ----------------------------------------
        objectAttributes=[[NSMutableDictionary alloc] init];
        NSArray *arAttr=[node attributes];
        NSUInteger i, countAttr = [arAttr count];
        if (![[node name] isEqualToString:@"text"]) {
            for (i = 0; i < countAttr; i++) {
                strValue=[[arAttr objectAtIndex:i] stringValue];
                strName=[[arAttr objectAtIndex:i] name];
                if(strValue && strName && ![strName isEqualToString:@"text"]){
                    [objectAttributes setValue:strValue forKey:strName];
                    
                }
                
            }
        }
        
        [object setValue:objectAttributes forKey:[node name]];
        // --------------------------------------------------------------------------------
        [self xmlTreeParserWithElement:node];
        // process to read elements of object ----------------------------------------

        
        [ar addObject:object];
        // --------------------------------------------------------------------------------
    }
   // NSLog(@"%@",ar);
    return ar;
}

-(void)xmlTreeParserWithElement:(CXMLElement*)node{

    NSUInteger j,countAttr, countElements = [node childCount];
    NSArray *arAttr;
    NSMutableArray *Arrs,*Arrs2;
    NSString *strName,*strValue;
    CXMLNode *element,*element11,*element12;
    CXMLElement *element2,*element3,*element4;
    
    NSMutableDictionary *elementDictionary=nil;
    for (j=0; j<countElements; j++)
    {
        element=[node childAtIndex:j];
        elementDictionary=[[NSMutableDictionary alloc] init];
        
        // process to read element attributes ----------------------------------
        if([element isMemberOfClass:[CXMLElement class]]){
            element2=(CXMLElement*)element;
            arAttr=[element2 attributes];
            countAttr=[arAttr count];
            if (![[element2 name] isEqualToString:@"text"]) {
                for (int i=0; i<countAttr; i++) {
                    strName=[[arAttr objectAtIndex:i] name];
                    strValue=[[arAttr objectAtIndex:i] stringValue];
                    if(strName && strValue&&![strName isEqualToString:@"text"]){
                        [elementDictionary setValue:strValue forKey:strName];
                    }
                }
            }
            [objectAttributes setValue:elementDictionary forKey:[element name]];
            Arrs = [NSMutableArray array];
            
            for (int i=0; i<[element childCount]; i++) {
                element11 = [element childAtIndex:i];
                
                elementDictionary=[[NSMutableDictionary alloc] init];
                if ([element11 isMemberOfClass:[CXMLElement class]]&&![[element11 name] isEqualToString:@"text"]) {
                    
                    element3 = (CXMLElement*)element11;
                    arAttr = [element3 attributes];
                    countAttr=[arAttr count];
                    for (int i=0; i<countAttr; i++) {
                        
                        strName=[[arAttr objectAtIndex:i] name];
                        strValue=[[arAttr objectAtIndex:i] stringValue];
                        if(strName && strValue&&![strName isEqualToString:@"text"]){
                            [elementDictionary setValue:strValue forKey:strName];
                        }
                    }
                    [Arrs addObject:elementDictionary];
                    Arrs2 = [NSMutableArray array];
                    for (int i=0; i<[element11 childCount]; i++) {
                        element12 = [element11 childAtIndex:i];
                        if ([[element12 name] isEqualToString:@"pages"]) {
                            for (int i=0; i<[element12 childCount]; i++) {
                                
                                if ([[element12 childAtIndex:i] isMemberOfClass:[CXMLElement class]]&&![[[element12 childAtIndex:i] name] isEqualToString:@"text"]) {
                                    element4 = (CXMLElement*)[element12 childAtIndex:i];
                                    arAttr = [element4 attributes];
                                    countAttr=[arAttr count];
                                    
                                    NSMutableDictionary *elementDictionary2=[[NSMutableDictionary alloc] init];
                                    for (int i=0; i<countAttr; i++) {
                                        
                                        strName=[[arAttr objectAtIndex:i] name];
                                        strValue=[[arAttr objectAtIndex:i] stringValue];
                                        if(strName && strValue&&![strName isEqualToString:@"text"]){
                                            [elementDictionary2 setValue:strValue forKey:strName];
                                        }
                                    }
                                    [Arrs2 addObject:elementDictionary2];
                                }
                                
                            }
                        }
                    }
                    [elementDictionary setValue:Arrs2 forKey:@"page"]; 
                }
                [objectAttributes setValue:Arrs forKey:[element11 name]]; 
                
            //    NSLog(@"%@",[objectAttributes objectForKey:[element name]]);
            }
            
            
        }
//        NSLog(@"%@",object);
        // --------------------------------------------------------------------
        
        // ---------------------------------------------------------------------
    }
    
}



// 遍历节点所有节点 返回节点值数组

- (NSArray *) parseDire2:(CXMLDocument *) document nodeName:(NSString*) nodePathName
{
    NSMutableArray *ar=[[NSMutableArray alloc] init];
    
    NSArray *nodes=nil;
    nodes=[document nodesForXPath:nodePathName error:nil];
    
    NSString *strValue;
    NSString *strName;
    
    for (CXMLElement *node in nodes) {
        NSMutableDictionary *object=[[NSMutableDictionary alloc] init];
        
        // process to set attributes of object ----------------------------------------
        objectAttributes=[[NSMutableDictionary alloc] init];
        NSArray *arAttr=[node attributes];
        NSUInteger i, countAttr = [arAttr count];
        for (i = 0; i < countAttr; i++) {
            strValue=[[arAttr objectAtIndex:i] stringValue];
            strName=[[arAttr objectAtIndex:i] name];
            if(strValue && strName){
                [objectAttributes setValue:strValue forKey:strName];
                
            }
        }
        
        [object setValue:objectAttributes forKey:[node name]];
        
        // --------------------------------------------------------------------------------
        
        [ar addObject:object];
        
        // --------------------------------------------------------------------------------
    }
//    NSLog(@"~~%@~~~",[ar description]);
    return ar;
}

- (NSArray *) parseRoot:(CXMLDocument *) document nodeName:(NSString*) nodePathName
{
    NSArray *node = NULL;
    NSMutableArray *ar=[[NSMutableArray alloc] init];
    node = [document nodesForXPath:nodePathName error:nil];
    for (CXMLElement *element in node)
    {
        if ([element isKindOfClass:[CXMLElement class]])
        {
            NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
            for (int i = 0; i < [element childCount]; i++)
            {
                if ([[[element children] objectAtIndex:i] isKindOfClass:[CXMLElement class]])
                {
                    [item setObject:[[element childAtIndex:i] stringValue]
                             forKey:[[element childAtIndex:i] name]
                     ];
                 //   NSLog(@"%@", [[element childAtIndex:i] stringValue]);
                }
            }
            [ar addObject:item];
        }
    }
    return ar;
}
@end
