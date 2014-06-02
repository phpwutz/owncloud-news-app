//
//  ServiceFactoryImpl.m
//  owncloudnews
//
//  Created by Lukas Köll on 30.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "OCNServiceFactoryImpl.h"
#import "OCNAppDelegate.h"

@implementation OCNServiceFactoryImpl

static OCNNewsFeedServiceImpl* newsFeedServiceImpl = nil;
static OCNNewsArticleServiceImpl* newsArticleServiceImpl = nil;
static OCNServiceFactoryImpl* serviceFactoryInstance = nil;
static OCNDatabaseService* databaseService = nil;

- (id) init{
    self = [super init];
    if(!self) return self;
    
    return self;
}

+ (OCNServiceFactoryImpl* ) getInstance{
    if(serviceFactoryInstance == nil){
        serviceFactoryInstance = [[OCNServiceFactoryImpl alloc] init];
    }
    return serviceFactoryInstance;
}



- (OCNNewsFeedServiceImpl*) getNewsFeedService{
    if(newsFeedServiceImpl == nil){
        newsFeedServiceImpl = [[OCNNewsFeedServiceImpl alloc] init];
    }
    return newsFeedServiceImpl;
}
- (OCNNewsArticleServiceImpl*) getNewsArticleService{
    if(newsArticleServiceImpl == nil){
        newsArticleServiceImpl = [[OCNNewsArticleServiceImpl alloc] init];
    }
    return newsArticleServiceImpl;
}

- (OCNOwncloudSyncService* ) getOwncloudSyncService{
    return [[OCNOwncloudSyncService alloc] init];
}

- (OCNDatabaseService*) getDatabaseService{
    if(databaseService == nil){
        databaseService = [[OCNDatabaseService alloc] init];
    }
    return databaseService;
}

@end
