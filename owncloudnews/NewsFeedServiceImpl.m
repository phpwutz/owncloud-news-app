//
//  NewsFeedServiceImpl.m
//  owncloudnews
//
//  Created by Lukas Köll on 30.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "NewsFeedServiceImpl.h"
#import "NewsFeed.h"
#import "Folder.h"

@implementation NewsFeedServiceImpl

- (id) initWithDb: (FMDatabase*)database{
    self = [super init];
    if (self) {
        self.db = database;
    }
    return self;
}
- (NSArray*) getAllFeeds{

    NSMutableArray* root = [[NSMutableArray alloc] init];
    NSMutableArray* output = [[NSMutableArray alloc] init];
    
	FMResultSet* res = [self.db executeQuery:@"SELECT * FROM feeds ORDER BY unreadCount DESC"];
    NSMutableArray* newArr = [[NSMutableArray alloc] init];
	while([res next])
	{
		[newArr addObject: [[NewsFeed alloc] initFromDbRow: res]];
	}
    
	FMResultSet* res2 = [self.db executeQuery:@"SELECT * FROM folders"];
	while([res2 next])
	{
        Folder* folder = [[Folder alloc] initFromDbRow: res2];
		[output addObject: folder];
        
        for(NewsFeed* feed in newArr){
            if(feed.folderId == folder.identity){
                [folder.feeds addObject: feed];
            }
        }
	}
    
    // add feeds that are not in a folder to global tree:
    for(NewsFeed* feed in newArr){
        if(feed.folderId == 0){
            [output addObject:feed];
        }
    }
    
    return [[NSArray alloc] initWithArray:output];
}

@end
