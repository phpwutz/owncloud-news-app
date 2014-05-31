//
//  ServiceFactoryImpl.h
//  owncloudnews
//
//  Created by Lukas Köll on 30.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsFeedServiceImpl.h"
#import "NewsArticleServiceImpl.h"
#import "OwncloudSyncService.h"
#import "FMDatabase.h"

@interface ServiceFactoryImpl : NSObject

@property (strong) FMDatabase* db;
+ (ServiceFactoryImpl* ) getInstance;
- (OwncloudSyncService* ) getOwncloudSyncService;
- (NewsFeedServiceImpl*) getNewsFeedService;
- (NewsArticleServiceImpl*) getNewsArticleService;

@end
