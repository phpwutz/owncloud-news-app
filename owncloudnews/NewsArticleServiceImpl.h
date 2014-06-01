//
//  NewsArticleServiceImpl.h
//  owncloudnews
//
//  Created by Lukas Köll on 30.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "NewsFeed.h"
#import "NewsItem.h"

@interface NewsArticleServiceImpl : NSObject

- (NSArray*) getArticlesForFeed: (NewsFeed* ) feed;
- (NewsItem*) getArticleById: (int) articleId;
- (void) markArticleRead: (NewsItem*) article;

@end
