/*
	SDZRoom.h
	The implementation of properties and methods for the SDZRoom object.
	Generated by SudzC.com
*/
#import "SDZRoom.h"

@implementation SDZRoom
	@synthesize bluetoothMac = _bluetoothMac;
	@synthesize boxIP = _boxIP;
	@synthesize boxMac = _boxMac;
	@synthesize hotelIP = _hotelIP;
	@synthesize _id = __id;
	@synthesize macAddress = _macAddress;
	@synthesize mobile = _mobile;
	@synthesize padIP = _padIP;
	@synthesize roomNo = _roomNo;
	@synthesize terminalType = _terminalType;

	- (id) init
	{
		if(self = [super init])
		{
			self.bluetoothMac = nil;
			self.boxIP = nil;
			self.boxMac = nil;
			self.hotelIP = nil;
			self.macAddress = nil;
			self.mobile = nil;
			self.padIP = nil;
			self.roomNo = nil;
			self.terminalType = nil;

		}
		return self;
	}

	+ (SDZRoom*) createWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return (SDZRoom*)[[SDZRoom alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self.bluetoothMac = [Soap getNodeValue: node withName: @"bluetoothMac"];
			self.boxIP = [Soap getNodeValue: node withName: @"boxIP"];
			self.boxMac = [Soap getNodeValue: node withName: @"boxMac"];
			self.hotelIP = [Soap getNodeValue: node withName: @"hotelIP"];
			self._id = [[Soap getNodeValue: node withName: @"id"] longLongValue];
			self.macAddress = [Soap getNodeValue: node withName: @"macAddress"];
			self.mobile = [Soap getNodeValue: node withName: @"mobile"];
			self.padIP = [Soap getNodeValue: node withName: @"padIP"];
			self.roomNo = [Soap getNodeValue: node withName: @"roomNo"];
			self.terminalType = [Soap getNodeValue: node withName: @"terminalType"];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"Room"];
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
		if (self.bluetoothMac != nil) [s appendFormat: @"<bluetoothMac>%@</bluetoothMac>", [[self.bluetoothMac stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.boxIP != nil) [s appendFormat: @"<boxIP>%@</boxIP>", [[self.boxIP stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.boxMac != nil) [s appendFormat: @"<boxMac>%@</boxMac>", [[self.boxMac stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.hotelIP != nil) [s appendFormat: @"<hotelIP>%@</hotelIP>", [[self.hotelIP stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		[s appendFormat: @"<id>%@</id>", [NSString stringWithFormat: @"%ld", self._id]];
		if (self.macAddress != nil) [s appendFormat: @"<macAddress>%@</macAddress>", [[self.macAddress stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.mobile != nil) [s appendFormat: @"<mobile>%@</mobile>", [[self.mobile stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.padIP != nil) [s appendFormat: @"<padIP>%@</padIP>", [[self.padIP stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.roomNo != nil) [s appendFormat: @"<roomNo>%@</roomNo>", [[self.roomNo stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.terminalType != nil) [s appendFormat: @"<terminalType>%@</terminalType>", [[self.terminalType stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[SDZRoom class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}

@end
