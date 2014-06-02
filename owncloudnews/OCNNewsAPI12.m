//
//  NewsAPI12.m
//  owncloudnews
//
//  Created by Lukas Köll on 28.01.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "OCNNewsAPI12.h"
#import "OCNNewsFeed.h"
#import "OCNNewsItem.h"
#import "OCNFolder.h"
#import "NSData+Base64.h"

@implementation OCNNewsAPI12

- (id) initWithProtocol: (NSString* ) protocol
              andDomain: (NSString* ) domain
            andUsername: (NSString* ) theUsername
            andPassword: (NSString*) thePassword
{
    self = [super init];
    if(self){
        apiUrl = [NSString stringWithFormat:@"%@%@/index.php/apps/news/api/v1-2/", protocol, domain];
        username = theUsername;
        password = thePassword;
    }
    return self;
}

- (void) updateSettingsFromUserDefaultsController
{
    NSUserDefaultsController* userDefaults = [NSUserDefaultsController sharedUserDefaultsController];
	NSString* protocol = [[userDefaults defaults] stringForKey:@"owncloudProtocol"];
	NSString* domain = [[userDefaults defaults] stringForKey:@"owncloudBaseUrl"];
	username = [[userDefaults defaults] stringForKey:@"owncloudUsername"];
	password = [[userDefaults defaults] stringForKey:@"owncloudPassword"];
	
    apiUrl = [NSString stringWithFormat:@"%@%@/index.php/apps/news/api/v1-2/", protocol, domain];
    
}

+ (BOOL) checkSettingsWithProtocol: (NSString* )theProtocol
                        andBaseUrl: (NSString* )theBaseUrl
                       andUsername: (NSString*) theUsername
                       andPassword: (NSString*) thePassword{
    NSHTTPURLResponse* response;
    
    NSString *theApiUrl = [NSString stringWithFormat:@"%@%@/index.php/apps/news/api/v1-2/", theProtocol, theBaseUrl];
    
    NSString* requestUrl = [theApiUrl stringByAppendingString: @"version"];
    
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString: requestUrl]
                                                            cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                        timeoutInterval:5.0];
    
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", theUsername, thePassword];
    NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedString]];
    [theRequest addValue:authValue forHTTPHeaderField:@"Authorization"];
    
    NSError* error = nil;
    @try{
        NSData* result = [NSURLConnection sendSynchronousRequest:theRequest  returningResponse:&response error:&error];
        
        NSInteger statusCode = [response statusCode];
        if(error != nil){
            return NO;
        }
        if(!statusCode == 200){ return NO; }
        
        NSError *localError = nil;
        NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:result options:0 error:&localError];
        if (localError != nil) { return NO; }
        if(! [parsedObject objectForKey:@"version"]){ return NO; }
    }@catch(NSException* ex ){
        return NO;
    }
    
    return YES;
}

/**
 * Folders
 */
- (NSArray*) getFolders{
    NSData* loadedData = [self loadRequest:@"folders"];
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:loadedData options:0 error:&localError];
    if (localError != nil) {
        @throw localError;
    }
    
    NSMutableArray *folderArray = [[NSMutableArray alloc] init];
    
    NSArray *results = [parsedObject valueForKey:@"folders"];
    NSLog(@"Loading %lu folders", (unsigned long)results.count);
    
    
    for (NSDictionary *groupDic in results) {
        OCNFolder *folder = [[OCNFolder alloc] initFromDictionary:groupDic];
        [folderArray addObject:folder];
    }
    
    return folderArray;
}

/**
 * Items
 */

// TODO: ist noch nicht fertig implementiert
- (NSArray*) getItemsFromId: (int) feedId
              withBatchSize: (int) batchSize
                 withOffset: (int) offset
                   withType: (NEWS_API_QUERY_TYPE) type
             withUnreadOnly: (BOOL) unreadOnly
{
    
    NSString* getParameters = [NSString stringWithFormat:@"items?getRead=true&id=%d", feedId];
    
    NSData* loadedData = [self loadRequest: getParameters];
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:loadedData options:0 error:&localError];
    
    if (localError != nil) {
        @throw localError;
    }
    
    NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    
    NSArray *results = [parsedObject valueForKey:@"items"];
    NSLog(@"Loading %lu items", (unsigned long)results.count);
    
    
    for (NSDictionary *groupDic in results) {
        OCNNewsItem *item = [[OCNNewsItem alloc] initFromDictionary:groupDic];
        [itemArray addObject:item];
    }
    return itemArray;
}
-(NSArray*) getUpdatedItemsFromId: (int) feedId
                 withLastModified: (int) lastModified
                         withType: (NEWS_API_QUERY_TYPE) type
{
    NSString* getParameters = [NSString stringWithFormat:@"items/updated?id=%d&type=%d&lastModified=%u", feedId, type, lastModified];
    NSData* loadedData = [self loadRequest: getParameters];
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:loadedData options:0 error:&localError];
    
    if (localError != nil) {
        @throw localError;
    }
    
    NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    
    NSArray *results = [parsedObject valueForKey:@"items"];
    NSLog(@"Loading %lu items", (unsigned long)results.count);
    
    
    for (NSDictionary *groupDic in results) {
        OCNNewsItem *folder = [[OCNNewsItem alloc] initFromDictionary:groupDic];
        [itemArray addObject:folder];
    }
    
    return itemArray;
}


/**
 * Feeds
 */
- (NSArray*) getAllFeeds
{
    
    NSData* loadedData = [self loadRequest:@"feeds"];

    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:loadedData options:0 error:&localError];
    
    if (localError != nil) {
        @throw localError;
    }
    
    NSMutableArray *feedArray = [[NSMutableArray alloc] init];
    
    NSArray *results = [parsedObject valueForKey:@"feeds"];
    NSLog(@"Loading %lu feeds", (unsigned long)results.count);
    
    
    for (NSDictionary *groupDic in results) {
        OCNNewsFeed *feed = [[OCNNewsFeed alloc] initFromDictionary:groupDic];
        [feedArray addObject:feed];
    }

    return feedArray;
    
    
}

/**
 * Helper Methods
 */
- (NSData*) loadRequest: (NSString*) urlAppendix
{
    NSURLResponse* response;
    
    NSString* requestUrl = [apiUrl stringByAppendingString: urlAppendix];
    
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString: requestUrl]
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
    
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", username, password];
    NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedString]];
    [theRequest addValue:authValue forHTTPHeaderField:@"Authorization"];
    
    NSError* error = nil;
    NSData* result = [NSURLConnection sendSynchronousRequest:theRequest  returningResponse:&response error:&error];
    NSString *resString = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    if(error != nil){
        NSLog(@"%@", error);
        @throw error;
    }
    return result;
}

@end
