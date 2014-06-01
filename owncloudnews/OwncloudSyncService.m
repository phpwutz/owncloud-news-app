//
//  OwncloudSyncService.m
//  owncloudnews
//
//  Created by Lukas Köll on 30.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "OwncloudSyncService.h"
#import "NewsFeed.h"
#import "NewsItem.h"
#import "ServiceFactoryImpl.h"
#import "DatabaseObserver.h"
#import "NSInvocation+Constructors.h"

@implementation OwncloudSyncService

- (id) init{
    self = [super init];
    if(self){
        NSUserDefaultsController* userDefaults = [NSUserDefaultsController sharedUserDefaultsController];
        NSString* protocol = [[userDefaults defaults] stringForKey:@"owncloudProtocol"];
        NSString* domain = [[userDefaults defaults] stringForKey:@"owncloudBaseUrl"];
        NSString* username = [[userDefaults defaults] stringForKey:@"owncloudUsername"];
        NSString* password = [[userDefaults defaults] stringForKey:@"owncloudPassword"];
        
        api = [[NewsAPI12 alloc] initWithProtocol:protocol andDomain:domain andUsername:username andPassword:password];
    }
    return self;
}

- (BOOL) syncDatabaseWithApi{
    
    /**
     sync:
     1. merge folders from remote
     2. merge feeds from remote
     TODO:
     3. check which of the newsitems is the latest
     4. load all newer items and sort them into their feeds
     5. optional: repeat step 3 and 4 until 4 return 0 items (batchsize)
     */
    @try {
        NSArray* folders = [api getFolders];
        NSArray* feeds = [api getAllFeeds];
        DatabaseService* db = [[ServiceFactoryImpl getInstance] getDatabaseService];
        [db executeUpdate:@"BEGIN TRANSACTION;"];
        for(Folder* folder in folders){
            [db executeUpdate:@"INSERT OR REPLACE INTO folders (id, folderName) VALUES (?, ?)", [NSNumber numberWithInteger: folder.identity], folder.title];
        }
        
        for(NewsFeed* feed in feeds){
            [db executeUpdate:@"INSERT OR REPLACE INTO feeds (id, unreadCount, folderId, url, title, faviconLink, link) VALUES (?, ?, ?, ?, ?, ?, ?)",
             [NSNumber numberWithInteger: feed.identity],
             [NSNumber numberWithInteger: feed.unreadCount],
             [NSNumber numberWithInteger: feed.folderId],
             feed.url,
             feed.title,
             feed.faviconLink,
             feed.link];
        }
        
        [db executeUpdate:@"END TRANSACTION;"];
        
        // get updated items:
        NSUserDefaultsController* userDefaults = [NSUserDefaultsController sharedUserDefaultsController];
        int lastModTimestamp = (int) [[userDefaults defaults] integerForKey:@"lastUpdateSync"];
        
        NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
        // NSTimeInterval is defined as double
        NSNumber* timeStampReal = [NSNumber numberWithDouble: timeStamp] ;
        
        NSArray* updatedItems = [api getUpdatedItemsFromId:0 withLastModified:lastModTimestamp withType: ALL];
        
        [db executeUpdate:@"BEGIN TRANSACTION;"];
        for(NewsItem* item in updatedItems){
            NSTimeInterval pubDateTS = [item.pubDate timeIntervalSince1970];
            
            [db executeUpdate:@"INSERT OR REPLACE INTO newsitems (id, feedId, guid, guidHash, url, title, author, pubDate, body, enclosureMime, unread, starred) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
             [NSNumber numberWithInteger:item.identity],
             [NSNumber numberWithInteger:item.feedId],
             item.guid,
             item.guidHash,
             item.url,
             item.title,
             item.author,
             [NSNumber numberWithInteger: (int)pubDateTS],
             item.body,
             item.enclosureMime,
             [NSNumber numberWithBool:item.unread],
             [NSNumber numberWithBool:item.starred]];
        }
        [db executeUpdate:@"END TRANSACTION;"];
        
        [[userDefaults defaults] setValue: [NSNumber numberWithInteger: [timeStampReal intValue]] forKey:@"lastUpdateSync"];
        [userDefaults save:self];
        
        NSInvocation* inv = [NSInvocation
                             invocationWithProtocol:@protocol(DatabaseObserver)
                             selector:@selector(databaseChanged)];
        [db notifyObservers:inv];
    }
    @catch (NSError *error) {
        return NO;
    }
    
    return YES;
}
@end
