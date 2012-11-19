/*
	SDZContTypeField.h
	The implementation of properties and methods for the SDZContTypeField object.
	Generated by SudzC.com
*/
#import "SDZContTypeField.h"

@implementation SDZContTypeField
	@synthesize addressData = _addressData;
	@synthesize _id = __id;
	@synthesize name = _name;
    @synthesize value = _value;
	@synthesize show = _show;

	- (id) init
	{
		if(self = [super init])
		{
			self.name = nil;

		}
		return self;
	}

	+ (SDZContTypeField*) createWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return (SDZContTypeField*)[[SDZContTypeField alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
            NSLog(@"%@",node);
			self.addressData = [[Soap getNodeValue: node withName: @"addressData"] boolValue];
			self._id = [[Soap getNodeValue: node withName: @"id"] intValue];
			self.name = [Soap getNodeValue: node withName: @"name"];
			self.value = [Soap getNodeValue: node withName: @"value"];
			self.show = [[Soap getNodeValue: node withName: @"show"] boolValue];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"ContTypeField"];
	}
  
	- (NSMutableString*) serialize: (NSString*) nodeName
	{
		NSMutableString* s = [NSMutableString string];
		[s appendFormat: @"<%@", nodeName];
		[s appendString: [self serializeAttributes]];
		[s appendString: @">"];
		[s appendString: [self serializeElements]];
		[s appendFormat: @"</%@>", nodeName];
		return s;
	}
	
	- (NSMutableString*) serializeElements
	{
		NSMutableString* s = [super serializeElements];
		[s appendFormat: @"<addressData>%@</addressData>", (self.addressData)?@"true":@"false"];
		[s appendFormat: @"<id>%@</id>", [NSString stringWithFormat: @"%i", self._id]];
		if (self.name != nil) [s appendFormat: @"<name>%@</name>", [[self.name stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		[s appendFormat: @"<show>%@</show>", (self.show)?@"true":@"false"];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[SDZContTypeField class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}

@end
