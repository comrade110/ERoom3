//
//  SoapDict.m
//  ERoom3
//
//  Created by user on 12-11-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SoapDict.h"



@implementation SoapDict



@synthesize items;



+ (id) newWithNode: (CXMLNode*) node

{
    
    return [[SoapDict alloc] initWithNode:node];
    
}



- (id) initWithNode: (CXMLNode*) node

{
    
    if(self = [self init]) {
        
    }
    
    return self;
    
}



+ (id) serialize: (NSDictionary*) dictionary

{
    
    NSMutableString* s = [NSMutableString string];
    
    return s;
    
}



- (id) object {
    
    return self.items;
    
}



- (NSUInteger)count {
    
    return [self.items count];
    
}



- (id)objectForKey:(id)aKey {
    
    return [self.items objectForKey:aKey];
    
}



- (NSEnumerator *)keyEnumerator {
    
    return [self.items keyEnumerator];
    
}



- (NSArray *)allKeys {
    
    return [self.items allKeys];
    
}



- (NSArray *)allKeysForObject:(id)anObject {
    
    return [self.items allKeysForObject:anObject];
    
}



- (NSArray *)allValues {
    
    return [self.items allValues];
    
}



- (NSString *)description {
    
    return [self.items description];
    
}



- (NSString *)descriptionInStringsFileFormat {
    
    return [self.items descriptionInStringsFileFormat];
    
}



- (NSString *)descriptionWithLocale:(id)locale {
    
    return [self.items descriptionWithLocale:locale];
    
}



- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    
    return [self.items descriptionWithLocale:locale indent:level];
    
}



- (BOOL)isEqualToDictionary:(NSDictionary *)otherDictionary {
    
    return [self.items isEqualToDictionary:otherDictionary];
    
}



- (NSEnumerator *)objectEnumerator {
    
    return [self.items objectEnumerator];
    
}



- (NSArray *)objectsForKeys:(NSArray *)keys notFoundMarker:(id)marker {
    
    return [self objectsForKeys:keys notFoundMarker:marker];
    
}



- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile {
    
    return [self.items writeToFile:path atomically:useAuxiliaryFile];
    
}



- (BOOL)writeToURL:(NSURL *)url atomically:(BOOL)atomically {
    
    return [self.items writeToURL:url atomically:atomically];
    
}



- (NSArray *)keysSortedByValueUsingSelector:(SEL)comparator {
    
    return [self.items keysSortedByValueUsingSelector:comparator];
    
}



- (void)getObjects:(id __unsafe_unretained [])objects andKeys:(id __unsafe_unretained [])keys {
    
    return [self.items getObjects:objects andKeys:keys];
    
}



+ (id)dictionary {
    
    return [[SoapDict alloc] init];
    
}



+ (id)dictionaryWithObject:(id)object forKey:(id)key {
    
    return [[SoapDict alloc] initWithObjectsAndKeys:object, key, nil];
    
}



+ (id)dictionaryWithObjects:(id *)objects forKeys:(id *)keys count:(NSUInteger)cnt {
    
    return [[SoapDict alloc] initWithObjects:objects forKeys:keys count:cnt];
    
}



+ (id)dictionaryWithObjectsAndKeys:(id)firstObject, ...{
    
    SoapDict* d = [SoapDict dictionary];
    
    BOOL isKey = NO;
    
    id eachObject;
    
    id key;
    
    id value;
    
    va_list argumentList;
    
    if (firstObject) {
        
        isKey = YES;
        
        value = firstObject;
        
        va_start(argumentList, firstObject);
        
        while ((eachObject = va_arg(argumentList, id))) {
            
            if(isKey) {
                
                key = eachObject;
                
                [d.items setObject:value forKey:key];
                
                isKey = NO;
                
                value = nil;
                
                key = nil;
                
            } else {
                
                value = eachObject;
                
            }
            
        }
        
        va_end(argumentList);
        
    }
    
    return d;
    
}



+ (id)dictionaryWithDictionary:(NSDictionary *)dict {
    
    return [[SoapDict alloc] initWithDictionary:dict];
    
}



+ (id)dictionaryWithObjects:(NSArray *)objects forKeys:(NSArray *)keys {
    
    return [[SoapDict alloc] initWithObjects:objects forKeys:keys];
    
}



- (id)initWithObjects:(id *)objects forKeys:(id *)keys count:(NSUInteger)cnt {
    
    return [[SoapDict alloc] initWithObjects:objects forKeys:keys count:cnt];
    
}



- (id)initWithObjectsAndKeys:(id)firstObject, ... {
    
    if(self = [self init]) {
        
        BOOL isKey = NO;
        
        id eachObject;
        
        id key;
        
        id value;
        
        va_list argumentList;
        
        if (firstObject) {
            
            value = firstObject;
            
            isKey = YES;
            
            va_start(argumentList, firstObject);
            
            while ((eachObject = va_arg(argumentList, id))) {
                
                if(isKey) {
                    
                    key = eachObject;
                    
                    [self.items setObject:value forKey:key];
                    
                    isKey = NO;
                    
                    value = nil;
                    
                    key = nil;
                    
                } else {
                    
                    value = eachObject;
                    
                }
                
            }
            
            va_end(argumentList);
            
        }
        
    }
    
    return self;
    
}



- (id)initWithDictionary:(NSDictionary *)otherDictionary {
    
    if (self = [self init]) {
        
        self.items = [[NSMutableDictionary alloc] initWithDictionary:otherDictionary];
        
    }
    
    return self;
    
}



- (id)initWithDictionary:(NSDictionary *)otherDictionary copyItems:(BOOL)flag {
    
    if (self = [self init]) {
        
        self.items = [[NSMutableDictionary alloc] initWithDictionary:otherDictionary];
        
    }
    
    return self;
    
}



- (id)initWithObjects:(NSArray *)objects forKeys:(NSArray *)keys {
    
    if (self = [self init]) {
        
        self.items = [[NSMutableDictionary alloc] initWithObjects:objects forKeys:keys];
        
    }
    
    return self;
    
}



+ (id)dictionaryWithContentsOfFile:(NSString *)path {
    
    return [[SoapDict alloc] initWithContentsOfFile:path];
    
}



+ (id)dictionaryWithContentsOfURL:(NSURL *)url {
    
    return [[SoapDict alloc] initWithContentsOfURL:url];
    
}



- (id)initWithContentsOfFile:(NSString *)path {
    
    if (self = [self init]) {
        
        self.items = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        
    }
    
    return self;
    
}



- (id)initWithContentsOfURL:(NSURL *)url {
    
    if (self = [self init]) {
        
        self.items = [[NSMutableDictionary alloc] initWithContentsOfURL:url];
        
    }
    
    return self;
    
}



- (void)removeObjectForKey:(id)aKey {
    
    [self.items removeObjectForKey:aKey];
    
}



- (void)setObject:(id)anObject forKey:(id)aKey {
    
    [self.items setObject:anObject forKey:aKey];
    
}



- (void)addEntriesFromDictionary:(NSDictionary *)otherDictionary {
    
    [self.items addEntriesFromDictionary:otherDictionary];
    
}



- (void)removeAllObjects {
    
    [self.items removeAllObjects];
    
}



- (void)removeObjectsForKeys:(NSArray *)keyArray {
    
    [self.items removeObjectsForKeys:keyArray];
    
}



- (void)setDictionary:(NSDictionary *)otherDictionary {
    
    [self.items setDictionary:otherDictionary];
    
}



+ (id)dictionaryWithCapacity:(NSUInteger)numItems {
    
    return [[SoapDict alloc] initWithCapacity:numItems];
    
}



- (id)initWithCapacity:(NSUInteger)numItems {
    
    if(self = [self init]) {
        
        self.items = [[NSMutableDictionary alloc] initWithCapacity:numItems];
        
    }
    
    return self;
    
}



- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])stackbuf count:(NSUInteger)len {
    
    return [self.items countByEnumeratingWithState:state objects:stackbuf count:len];
    
}



- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [self.items encodeWithCoder:aCoder];
    
}



- (id)initWithCoder:(NSCoder *)aDecoder {
    
    return [self.items initWithCoder:aDecoder];
    
}



- (id)copyWithZone:(NSZone *)zone {
    
    return [self.items copyWithZone:zone];
    
}



- (id)mutableCopyWithZone:(NSZone *)zone {
    
    return [self.items mutableCopyWithZone:zone];
    
}



@end
