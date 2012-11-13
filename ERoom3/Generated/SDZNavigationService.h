/*
	SDZNavigationService.h
	The interface definition of classes and methods for the NavigationService web service.
	Generated by SudzC.com
*/
				
#import "Soap.h"
	
/* Add class references */
				
#import "SDZModuleList.h"
#import "SDZRelationList.h"
#import "SDZContentList.h"
#import "SDZArrayOfCatalog.h"
#import "SDZContType.h"
#import "SDZCatalogGroup.h"
#import "SDZCatalog.h"
#import "SDZContTypeField2stringMap.h"
#import "SDZContType2CatalogGroup2ArrayOfCatalogMapMap.h"
#import "SDZCatalogGroup2ArrayOfCatalogMap.h"
#import "SDZModule.h"
#import "SDZRelation.h"
#import "SDZContTypeField.h"
#import "SDZContent.h"

/* Interface for the service */
				
@interface SDZNavigationService : SoapService
		
	/* Returns long.  */
	- (SoapRequest*) countContentInfo: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId contTypeId: (NSString*) contTypeId catalogIds: (NSString*) catalogIds;
	- (SoapRequest*) countContentInfo: (id) target action: (SEL) action sessionId: (NSString*) sessionId contTypeId: (NSString*) contTypeId catalogIds: (NSString*) catalogIds;

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) findAllModules: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId;
	- (SoapRequest*) findAllModules: (id) target action: (SEL) action sessionId: (NSString*) sessionId;

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) findSingleContentRelations: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId contTypeId: (NSString*) contTypeId contId: (NSString*) contId;
	- (SoapRequest*) findSingleContentRelations: (id) target action: (SEL) action sessionId: (NSString*) sessionId contTypeId: (NSString*) contTypeId contId: (NSString*) contId;

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) findSingleContentDetails: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId contTypeId: (NSString*) contTypeId contId: (NSString*) contId;
	- (SoapRequest*) findSingleContentDetails: (id) target action: (SEL) action sessionId: (NSString*) sessionId contTypeId: (NSString*) contTypeId contId: (NSString*) contId;

	/* Returns int.  */
	- (SoapRequest*) getMoudleIdByModuleEntry: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId moduleEntry: (NSString*) moduleEntry;
	- (SoapRequest*) getMoudleIdByModuleEntry: (id) target action: (SEL) action sessionId: (NSString*) sessionId moduleEntry: (NSString*) moduleEntry;

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) findSingleContentRelationContentInfo: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId contTypeId: (NSString*) contTypeId relationId: (NSString*) relationId contId: (NSString*) contId pageNo: (NSString*) pageNo perPageNum: (NSString*) perPageNum;
	- (SoapRequest*) findSingleContentRelationContentInfo: (id) target action: (SEL) action sessionId: (NSString*) sessionId contTypeId: (NSString*) contTypeId relationId: (NSString*) relationId contId: (NSString*) contId pageNo: (NSString*) pageNo perPageNum: (NSString*) perPageNum;

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) findContTypeAndCatalogGroupAndCatalog: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId moduleId: (NSString*) moduleId;
	- (SoapRequest*) findContTypeAndCatalogGroupAndCatalog: (id) target action: (SEL) action sessionId: (NSString*) sessionId moduleId: (NSString*) moduleId;

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) findContentInfo: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId contTypeId: (NSString*) contTypeId catalogIds: (NSString*) catalogIds pageNo: (NSString*) pageNo perPageNum: (NSString*) perPageNum;
	- (SoapRequest*) findContentInfo: (id) target action: (SEL) action sessionId: (NSString*) sessionId contTypeId: (NSString*) contTypeId catalogIds: (NSString*) catalogIds pageNo: (NSString*) pageNo perPageNum: (NSString*) perPageNum;

		
	+ (SDZNavigationService*) service;
	+ (SDZNavigationService*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password;
@end
	