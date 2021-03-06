/*
	SDZHotelTicketDetail.h
	The interface definition of properties and methods for the SDZHotelTicketDetail object.
	Generated by SudzC.com
*/

#import "Soap.h"
	

@interface SDZHotelTicketDetail : SoapObject
{
	double _amount;
	NSString* _detailName;
	long __id;
	int _numbers;
	double _price;
	long _ticketId;
	
}
		
	@property double amount;
	@property (retain, nonatomic) NSString* detailName;
	@property long _id;
	@property int numbers;
	@property double price;
	@property long ticketId;

	+ (SDZHotelTicketDetail*) createWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
