//
//  ServiceFactoryImpl.m
//  owncloudnews
//
//  Created by Lukas Köll on 30.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "ServiceFactoryImpl.h"
#import "AppDelegate.h"

@implementation ServiceFactoryImpl

static NewsFeedServiceImpl* newsFeedServiceImpl = nil;
static NewsArticleServiceImpl* newsArticleServiceImpl = nil;
static ServiceFactoryImpl* serviceFactoryInstance = nil;
static DatabaseService* databaseService = nil;

- (id) init{
    self = [super init];
    if(!self) return self;
    
    return self;
}

+ (ServiceFactoryImpl* ) getInstance{
    if(serviceFactoryInstance == nil){
        serviceFactoryInstance = [[ServiceFactoryImpl alloc] init];
    }
    return serviceFactoryInstance;
}



- (NewsFeedServiceImpl*) getNewsFeedService{
    if(newsFeedServiceImpl == nil){
        newsFeedServiceImpl = [[NewsFeedServiceImpl alloc] init];
    }
    return newsFeedServiceImpl;
}
- (NewsArticleServiceImpl*) getNewsArticleService{
    if(newsArticleServiceImpl == nil){
        newsArticleServiceImpl = [[NewsArticleServiceImpl alloc] init];
    }
    return newsArticleServiceImpl;
}

- (OwncloudSyncService* ) getOwncloudSyncService{
    return [[OwncloudSyncService alloc] init];
}

- (DatabaseService*) getDatabaseService{
    if(databaseService == nil){
        databaseService = [[DatabaseService alloc] init];
    }
    return databaseService;
}

@end
