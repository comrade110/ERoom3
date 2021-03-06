/*
	SDZCatalogGroup.h
	The implementation of properties and methods for the SDZCatalogGroup object.
	Generated by SudzC.com
*/
#import "SDZCatalogGroup.h"

@implementation SDZCatalogGroup
	@synthesize _id = __id;
	@synthesize name = _name;

	- (id) init
	{
		if(self = [super init])
		{
			self.name = nil;

		}
		return self;
	}

	+ (SDZCatalogGroup*) createWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return (SDZCatalogGroup*)[[SDZCatalogGroup alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self._id = [[Soap getNodeValue: node withName: @"id"] intValue];
			self.name = [Soap getNodeValue: node withName: @"name"];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"CatalogGroup"];
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
		[s appendFormat: @"<id>%@</id>", [NSString stringWithFormat: @"%i", self._id]];
		if (self.name != nil) [s appendFormat: @"<name>%@</name>", [[self.name stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[SDZCatalogGroup class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}

@end
