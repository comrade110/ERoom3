/*
	SDZArrayOfCatalog.h
	The implementation of properties and methods for the SDZArrayOfCatalog array.
	Generated by SudzC.com
*/
#import "SDZArrayOfCatalog.h"

#import "SDZCatalog.h"
@implementation SDZArrayOfCatalog

	+ (id) createWithNode: (CXMLNode*) node
	{
		return [[SDZArrayOfCatalog alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				SDZCatalog* value = [[SDZCatalog createWithNode: child] object];
				if(value != nil) {
					[self addObject: value];
				}
			}
		}
		return self;
	}
	
	+ (NSMutableString*) serialize: (NSArray*) array
	{
		NSMutableString* s = [NSMutableString string];
		for(id item in array) {
			[s appendString: [item serialize: @"Catalog"]];
		}
		return s;
	}
@end