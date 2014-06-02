//
//  NewsArticleServiceImpl.m
//  owncloudnews
//
//  Created by Lukas Köll on 30.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "OCNNewsArticleServiceImpl.h"
#import "OCNNewsItem.h"
#import "OCNServiceFactoryImpl.h"

@implementation OCNNewsArticleServiceImpl

- (NSArray*) getArticlesForFeed: (OCNNewsFeed*) feed{
    NSMutableArray* output = [[NSMutableArray alloc] init];
    OCNDatabaseService* db = [[OCNServiceFactoryImpl getInstance] getDatabaseService];
    FMResultSet* res = [db executeQuery:@"SELECT * FROM newsitems WHERE feedId = ? ORDER BY pubDate DESC", [NSNumber numberWithInt:feed.identity]];
    
    while([res next])
    {
        OCNNewsItem* item = [[OCNNewsItem alloc] initFromDbRow: res];
        [output addObject: item];
    }

    return [[NSArray alloc] initWithArray:output];
}

- (OCNNewsItem*) getArticleById: (int) articleId{
    OCNDatabaseService* db = [[OCNServiceFactoryImpl getInstance] getDatabaseService];
    FMResultSet* res = [db executeQuery:@"SELECT * FROM newsitems WHERE id = ? ORDER BY pubDate DESC", articleId];
    [res next];
    if(res){
        return [[OCNNewsItem alloc] initFromDbRow: res];
    }
    return nil;
}

- (void) markArticleRead: (OCNNewsItem*) article{
    OCNDatabaseService* db = [[OCNServiceFactoryImpl getInstance] getDatabaseService];
    [db executeUpdate: @"UPDATE newsitems SET unread = 0 WHERE id = ?", [article identity]];
}
@end
