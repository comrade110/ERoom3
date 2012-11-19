/*
	SDZContTypeField.h
	The interface definition of properties and methods for the SDZContTypeField object.
	Generated by SudzC.com
*/

#import "Soap.h"
	

@interface SDZContTypeField : SoapObject
{
	BOOL _addressData;
	int __id;
	NSString* _name;
    NSString* _value;
	BOOL _show;
	
}
		
	@property BOOL addressData;
@property int _id;
@property (retain, nonatomic) NSString* name;
@property (retain, nonatomic) NSString* value;
	@property BOOL show;

	+ (SDZContTypeField*) createWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
