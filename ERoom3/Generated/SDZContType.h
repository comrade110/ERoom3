/*
	SDZContType.h
	The interface definition of properties and methods for the SDZContType object.
	Generated by SudzC.com
*/

#import "Soap.h"
	

@interface SDZContType : SoapObject
{
	int __id;
	NSString* _name;
	
}
		
	@property int _id;
	@property (retain, nonatomic) NSString* name;
    @property (retain, nonatomic) NSMutableArray *valueArr;

	+ (SDZContType*) createWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
