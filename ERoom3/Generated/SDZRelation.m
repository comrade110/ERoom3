/*
	SDZRelation.h
	The implementation of properties and methods for the SDZRelation object.
	Generated by SudzC.com
*/
#import "SDZRelation.h"

@implementation SDZRelation
	@synthesize rightContTypeId = _rightContTypeId;
	@synthesize selfid = _selfid;
	@synthesize selfname = _selfname;

	- (id) init
	{
		if(self = [super init])
		{
			self.rightContTypeId = nil;
			self.selfname = nil;

		}
		return self;
	}

	+ (SDZRelation*) createWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return (SDZRelation*)[[SDZRelation alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self.rightContTypeId = [Soap getNodeValue: node withName: @"rightContTypeId"];
			self.selfid = [[Soap getNodeValue: node withName: @"selfid"] longLongValue];
			self.selfname = [Soap getNodeValue: node withName: @"selfname"];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"Relation"];
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
		if (self.rightContTypeId != nil) [s appendFormat: @"<rightContTypeId>%@</rightContTypeId>", [[self.rightContTypeId stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		[s appendFormat: @"<selfid>%@</selfid>", [NSString stringWithFormat: @"%ld", self.selfid]];
		if (self.selfname != nil) [s appendFormat: @"<selfname>%@</selfname>", [[self.selfname stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[SDZRelation class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}

@end
