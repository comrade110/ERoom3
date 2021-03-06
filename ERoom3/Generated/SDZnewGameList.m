/*
	SDZnewGameList.h
	The implementation of properties and methods for the SDZnewGameList array.
	Generated by SudzC.com
*/
#import "SDZnewGameList.h"

#import "SDZGame.h"
@implementation SDZnewGameList

	+ (id) createWithNode: (CXMLNode*) node
	{
		return [[SDZnewGameList alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				SDZGame* value = [[SDZGame createWithNode: child] object];
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
			[s appendString: [item serialize: @"Game"]];
		}
		return s;
	}
@end
