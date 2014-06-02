//
//  NewsArticleServiceImpl.h
//  owncloudnews
//
//  Created by Lukas Köll on 30.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "OCNNewsFeed.h"
#import "OCNNewsItem.h"

@interface OCNNewsArticleServiceImpl : NSObject

- (NSArray*) getArticlesForFeed: (OCNNewsFeed* ) feed;
- (OCNNewsItem*) getArticleById: (int) articleId;
- (void) markArticleRead: (OCNNewsItem*) article;

@end
