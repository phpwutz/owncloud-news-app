//
//  ServiceFactoryImpl.h
//  owncloudnews
//
//  Created by Lukas Köll on 30.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCNNewsFeedServiceImpl.h"
#import "OCNNewsArticleServiceImpl.h"
#import "OCNOwncloudSyncService.h"
#import "FMDatabase.h"
#import "OCNDatabaseService.h"

@interface OCNServiceFactoryImpl : NSObject

+ (OCNServiceFactoryImpl* ) getInstance;
- (OCNOwncloudSyncService* ) getOwncloudSyncService;
- (OCNNewsFeedServiceImpl*) getNewsFeedService;
- (OCNNewsArticleServiceImpl*) getNewsArticleService;
- (OCNDatabaseService*) getDatabaseService;

@end
