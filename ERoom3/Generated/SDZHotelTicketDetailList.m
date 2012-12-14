/*
	SDZHotelTicketDetailList.h
	The implementation of properties and methods for the SDZHotelTicketDetailList array.
	Generated by SudzC.com
*/
#import "SDZHotelTicketDetailList.h"

#import "SDZHotelTicketDetail.h"
@implementation SDZHotelTicketDetailList

	+ (id) createWithNode: (CXMLNode*) node
	{
		return [[SDZHotelTicketDetailList alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				SDZHotelTicketDetail* value = [[SDZHotelTicketDetail createWithNode: child] object];
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
			[s appendString: [item serialize: @"HotelTicketDetail"]];
		}
		return s;
	}
@end