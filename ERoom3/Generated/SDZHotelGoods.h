/*
	SDZHotelGoods.h
	The interface definition of properties and methods for the SDZHotelGoods object.
	Generated by SudzC.com
*/

#import "Soap.h"
	

@interface SDZHotelGoods : SoapObject
{
	NSString* _bigImg;
	int __id;
	NSString* _memo;
	NSString* _name;
	double _price;
	BOOL _recomment;
	NSString* _smallImg;
	BOOL _special;
	double _specialPrice;
	NSString* _unit;
	
}
		
	@property (retain, nonatomic) NSString* bigImg;
	@property int _id;
	@property (retain, nonatomic) NSString* memo;
	@property (retain, nonatomic) NSString* name;
	@property double price;
	@property BOOL recomment;
	@property (retain, nonatomic) NSString* smallImg;
	@property BOOL special;
	@property double specialPrice;
	@property (retain, nonatomic) NSString* unit;

	+ (SDZHotelGoods*) createWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
