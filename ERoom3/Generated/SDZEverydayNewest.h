/*
	SDZEverydayNewest.h
	The interface definition of properties and methods for the SDZEverydayNewest object.
	Generated by SudzC.com
*/

#import "Soap.h"
	

@interface SDZEverydayNewest : SoapObject
{
	NSString* _date;
	NSString* _desc;
	NSString* _iconImageRef;
	long __id;
	NSString* _name;
	int _type;
	NSString* _videoRef;
	
}
		
	@property (retain, nonatomic) NSString* date;
	@property (retain, nonatomic) NSString* desc;
	@property (retain, nonatomic) NSString* iconImageRef;
	@property long _id;
	@property (retain, nonatomic) NSString* name;
	@property int type;
	@property (retain, nonatomic) NSString* videoRef;

	+ (SDZEverydayNewest*) createWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
