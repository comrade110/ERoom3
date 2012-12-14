/*
	SDZHotelTicket.h
	The interface definition of properties and methods for the SDZHotelTicket object.
	Generated by SudzC.com
*/

#import "Soap.h"
	

@interface SDZHotelTicket : SoapObject
{
	long __id;
	double _servicePrice;
	NSString* _tDate;
	
}
		
	@property long _id;
	@property double servicePrice;
	@property (retain, nonatomic) NSString* tDate;

	+ (SDZHotelTicket*) createWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
