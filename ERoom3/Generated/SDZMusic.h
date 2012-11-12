/*
	SDZMusic.h
	The interface definition of properties and methods for the SDZMusic object.
	Generated by SudzC.com
*/

#import "Soap.h"
	

@interface SDZMusic : SoapObject
{
	int _combType;
	long __id;
	NSString* _lyric;
	NSString* _lyricFileRef;
	NSString* _musicFile;
	NSString* _musicName;
	int _musicType;
	int _recomment;
	int _regionType;
	NSString* _releaseTime;
	NSString* _singer;
	NSString* _singerImage;
	NSString* _specialImage;
	NSString* _specialName;
	long _useCount;
	
}
		
	@property int combType;
	@property long _id;
	@property (retain, nonatomic) NSString* lyric;
	@property (retain, nonatomic) NSString* lyricFileRef;
	@property (retain, nonatomic) NSString* musicFile;
	@property (retain, nonatomic) NSString* musicName;
	@property int musicType;
	@property int recomment;
	@property int regionType;
	@property (retain, nonatomic) NSString* releaseTime;
	@property (retain, nonatomic) NSString* singer;
	@property (retain, nonatomic) NSString* singerImage;
	@property (retain, nonatomic) NSString* specialImage;
	@property (retain, nonatomic) NSString* specialName;
	@property long useCount;

	+ (SDZMusic*) createWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end