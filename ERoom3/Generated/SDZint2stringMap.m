/*
	SDZint2stringMap.h
	The implementation of properties and methods for the SDZint2stringMap array.
	Generated by SudzC.com
*/
#import "SDZint2stringMap.h"

@implementation SDZint2stringMap

	+ (id) createWithNode: (CXMLNode*) node
	{
		return [[SDZint2stringMap alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				NSNumber* value = [NSNumber numberWithInt: [[child stringValue] intValue]];
				[self addObject: value];
			}
		}
		return self;
	}
	
	+ (NSMutableString*) serialize: (NSArray*) array
	{
		NSMutableString* s = [NSMutableString string];
		for(id item in array) {
			[s appendString: [NSString stringWithFormat: @"%@", item]];
		}
		return s;
	}
@end
