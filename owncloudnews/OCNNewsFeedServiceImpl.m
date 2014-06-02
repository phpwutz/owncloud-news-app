//
//  NewsFeedServiceImpl.m
//  owncloudnews
//
//  Created by Lukas Köll on 30.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "OCNNewsFeedServiceImpl.h"
#import "OCNNewsFeed.h"
#import "OCNFolder.h"
#import "OCNServiceFactoryImpl.h"

@implementation OCNNewsFeedServiceImpl

- (NSArray*) getAllFeeds{

    NSMutableArray* root = [[NSMutableArray alloc] init];
    NSMutableArray* output = [[NSMutableArray alloc] init];
    
    OCNDatabaseService* db = [[OCNServiceFactoryImpl getInstance] getDatabaseService];
    
	FMResultSet* res = [db executeQuery:@"SELECT * FROM feeds ORDER BY unreadCount DESC"];
    NSMutableArray* newArr = [[NSMutableArray alloc] init];
	while([res next])
	{
		[newArr addObject: [[OCNNewsFeed alloc] initFromDbRow: res]];
	}
    
	FMResultSet* res2 = [db executeQuery:@"SELECT * FROM folders"];
	while([res2 next])
	{
        OCNFolder* folder = [[OCNFolder alloc] initFromDbRow: res2];
		[output addObject: folder];
        
        for(OCNNewsFeed* feed in newArr){
            if(feed.folderId == folder.identity){
                [folder.feeds addObject: feed];
            }
        }
	}
    
    // add feeds that are not in a folder to global tree:
    for(OCNNewsFeed* feed in newArr){
        if(feed.folderId == 0){
            [output addObject:feed];
        }
    }
    
    return [[NSArray alloc] initWithArray:output];
}

@end
