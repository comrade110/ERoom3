/*
	SDZUserService.m
	The implementation classes and methods for the UserService web service.
	Generated by SudzC.com
*/

#import "SDZUserService.h"
				
#import "Soap.h"
	
#import "SDZHotelTicketDetailList.h"
#import "SDZHotelGoodsCatalogList.h"
#import "SDZHotelGoodsList.h"
#import "SDZHotelGoods.h"
#import "SDZHotelTicket.h"
#import "SDZHotelGoodsCatalog.h"
#import "SDZHotelTicketDetail.h"

/* Implementation of the service */
				
@implementation SDZUserService

	- (id) init
	{
		if(self = [super init])
		{
			self.serviceUrl = @"http://192.168.3.108/hotels/services/UserService";
			self.namespace = @"http://soap.user/";
			self.headers = nil;
			self.logging = NO;
		}
		return self;
	}
	
	- (id) initWithUsername: (NSString*) username andPassword: (NSString*) password {
		if(self = [super initWithUsername:username andPassword:password]) {
		}
		return self;
	}
	
	+ (SDZUserService*) service {
		return [SDZUserService serviceWithUsername:nil andPassword:nil];
	}
	
	+ (SDZUserService*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password {
		return [[SDZUserService alloc] initWithUsername:username andPassword:password];
	}

		
	/* Returns NSMutableArray*.  */
	- (SoapRequest*) deleteTicketDetail: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId ticketDetailId: (NSString*) ticketDetailId
	{
		return [self deleteTicketDetail: handler action: nil sessionId: sessionId ticketDetailId: ticketDetailId];
	}

	- (SoapRequest*) deleteTicketDetail: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId ticketDetailId: (NSString*) ticketDetailId
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: ticketDetailId forName: @"ticketDetailId"]];
		NSString* _envelope = [Soap createEnvelope: @"deleteTicketDetail" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: [SDZHotelTicketDetailList alloc]];
		[_request send];
		return _request;
	}

	/* Returns SDZHotelTicket*.  */
	- (SoapRequest*) findHotelTicket: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId ticketId: (NSString*) ticketId
	{
		return [self findHotelTicket: handler action: nil sessionId: sessionId ticketId: ticketId];
	}

	- (SoapRequest*) findHotelTicket: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId ticketId: (NSString*) ticketId
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: ticketId forName: @"ticketId"]];
		NSString* _envelope = [Soap createEnvelope: @"findHotelTicket" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: [SDZHotelTicket alloc]];
		[_request send];
		return _request;
	}

	/* Returns BOOL.  */
	- (SoapRequest*) canHandlerOrder: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId
	{
		return [self canHandlerOrder: handler action: nil sessionId: sessionId];
	}

	- (SoapRequest*) canHandlerOrder: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		NSString* _envelope = [Soap createEnvelope: @"canHandlerOrder" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"BOOL"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) getServicePay: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId goodType: (NSString*) goodType
	{
		return [self getServicePay: handler action: nil sessionId: sessionId goodType: goodType];
	}

	- (SoapRequest*) getServicePay: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId goodType: (NSString*) goodType
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: goodType forName: @"goodType"]];
		NSString* _envelope = [Soap createEnvelope: @"getServicePay" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns id.  */
	- (SoapRequest*) clearTicket: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId ticketId: (NSString*) ticketId
	{
		return [self clearTicket: handler action: nil sessionId: sessionId ticketId: ticketId];
	}

	- (SoapRequest*) clearTicket: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId ticketId: (NSString*) ticketId
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: ticketId forName: @"ticketId"]];
		NSString* _envelope = [Soap createEnvelope: @"clearTicket" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: nil];
		[_request send];
		return _request;
	}

	/* Returns id.  */
	- (SoapRequest*) submitTicket: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId ticketId: (NSString*) ticketId
	{
		return [self submitTicket: handler action: nil sessionId: sessionId ticketId: ticketId];
	}

	- (SoapRequest*) submitTicket: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId ticketId: (NSString*) ticketId
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: ticketId forName: @"ticketId"]];
		NSString* _envelope = [Soap createEnvelope: @"submitTicket" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: nil];
		[_request send];
		return _request;
	}

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) findCatalogs: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId goodsType: (NSString*) goodsType
	{
		return [self findCatalogs: handler action: nil sessionId: sessionId goodsType: goodsType];
	}

	- (SoapRequest*) findCatalogs: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId goodsType: (NSString*) goodsType
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: goodsType forName: @"goodsType"]];
		NSString* _envelope = [Soap createEnvelope: @"findCatalogs" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: [SDZHotelGoodsCatalogList alloc]];
		[_request send];
		return _request;
	}

	/* Returns SDZHotelTicket*.  */
	- (SoapRequest*) addHotelFoodTicket: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId goodType: (NSString*) goodType goodId: (NSString*) goodId amount: (NSString*) amount
	{
		return [self addHotelFoodTicket: handler action: nil sessionId: sessionId goodType: goodType goodId: goodId amount: amount];
	}

	- (SoapRequest*) addHotelFoodTicket: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId goodType: (NSString*) goodType goodId: (NSString*) goodId amount: (NSString*) amount
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: goodType forName: @"goodType"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: goodId forName: @"goodId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: amount forName: @"amount"]];
		NSString* _envelope = [Soap createEnvelope: @"addHotelFoodTicket" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: [SDZHotelTicket alloc]];
		[_request send];
		return _request;
	}

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) updateTicketDetail: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId ticketDetailId: (NSString*) ticketDetailId amount: (NSString*) amount
	{
		return [self updateTicketDetail: handler action: nil sessionId: sessionId ticketDetailId: ticketDetailId amount: amount];
	}

	- (SoapRequest*) updateTicketDetail: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId ticketDetailId: (NSString*) ticketDetailId amount: (NSString*) amount
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: ticketDetailId forName: @"ticketDetailId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: amount forName: @"amount"]];
		NSString* _envelope = [Soap createEnvelope: @"updateTicketDetail" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: [SDZHotelTicketDetailList alloc]];
		[_request send];
		return _request;
	}

	/* Returns long.  */
	- (SoapRequest*) countHotelFood: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId goodsType: (NSString*) goodsType catalog: (NSString*) catalog
	{
		return [self countHotelFood: handler action: nil sessionId: sessionId goodsType: goodsType catalog: catalog];
	}

	- (SoapRequest*) countHotelFood: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId goodsType: (NSString*) goodsType catalog: (NSString*) catalog
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: goodsType forName: @"goodsType"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: catalog forName: @"catalog"]];
		NSString* _envelope = [Soap createEnvelope: @"countHotelFood" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"long"];
		[_request send];
		return _request;
	}

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) findTicketDetails: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId goodType: (NSString*) goodType
	{
		return [self findTicketDetails: handler action: nil sessionId: sessionId goodType: goodType];
	}

	- (SoapRequest*) findTicketDetails: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId goodType: (NSString*) goodType
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: goodType forName: @"goodType"]];
		NSString* _envelope = [Soap createEnvelope: @"findTicketDetails" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: [SDZHotelTicketDetailList alloc]];
		[_request send];
		return _request;
	}

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) findHotelFood: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId goodsType: (NSString*) goodsType catalog: (NSString*) catalog pageNo: (NSString*) pageNo perPageNum: (NSString*) perPageNum
	{
		return [self findHotelFood: handler action: nil sessionId: sessionId goodsType: goodsType catalog: catalog pageNo: pageNo perPageNum: perPageNum];
	}

	- (SoapRequest*) findHotelFood: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId goodsType: (NSString*) goodsType catalog: (NSString*) catalog pageNo: (NSString*) pageNo perPageNum: (NSString*) perPageNum
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: goodsType forName: @"goodsType"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: catalog forName: @"catalog"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: pageNo forName: @"pageNo"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: perPageNum forName: @"perPageNum"]];
		NSString* _envelope = [Soap createEnvelope: @"findHotelFood" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: [SDZHotelGoodsList alloc]];
		[_request send];
		return _request;
	}


@end
	