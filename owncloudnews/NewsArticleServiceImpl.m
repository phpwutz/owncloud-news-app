//
//  NewsArticleServiceImpl.m
//  owncloudnews
//
//  Created by Lukas Köll on 30.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "NewsArticleServiceImpl.h"
#import "NewsItem.h"

@implementation NewsArticleServiceImpl

- (id) initWithDb: (FMDatabase*)database{
    self = [super init];
    if (self) {
        db = database;
    }
    return self;
}

- (NSArray*) getArticlesForFeed: (NewsFeed*) feed{
    NSMutableArray* output = [[NSMutableArray alloc] init];
    
    FMResultSet* res = [db executeQuery:@"SELECT * FROM newsitems WHERE feedId = ? ORDER BY pubDate DESC", [NSNumber numberWithInt:feed.identity]];
    
    while([res next])
    {
        NewsItem* item = [[NewsItem alloc] initFromDbRow: res];
        [output addObject: item];
    }

    return [[NSArray alloc] initWithArray:output];
}

- (NewsItem*) getArticleById: (int) articleId{
    FMResultSet* res = [db executeQuery:@"SELECT * FROM newsitems WHERE id = ? ORDER BY pubDate DESC", articleId];
    [res next];
    if(res){
        return [[NewsItem alloc] initFromDbRow: res];
    }
    return nil;
}

- (void) markArticleRead: (NewsItem*) article{
    [db executeUpdate: @"UPDATE newsitems SET unread = 0 WHERE id = ?", [article identity]];
}
@end
