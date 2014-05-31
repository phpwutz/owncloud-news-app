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

- (id) init{
    self = [super init];
    if(!self) return self;
    
    NSString* dbPath = [self getDatabasePath];
    NSLog(@"%@", dbPath);
    self.db = [FMDatabase databaseWithPath: dbPath];
    if (![self.db open]) {
        [self initializeDatabase];
    }
    
    FMResultSet* res = [self.db executeQuery:@"SELECT * from feeds" ];
    if(res == nil){ // initialize db schema if not done yet
        
    }
    [[self getOwncloudSyncService] syncDatabaseWithApi];
    return self;
}

- (void) initializeDatabase{
    NSError* err;
    NSString *dbSchemaPath = [[NSBundle mainBundle] pathForResource:@"dbschema" ofType:@"sqlite"];
    NSString *dbSchemaContents = [NSString stringWithContentsOfFile: dbSchemaPath encoding:NSUTF8StringEncoding error:&err];
    
    NSArray *commandsArray = [dbSchemaContents componentsSeparatedByString: @"\n"];
    
    for (NSString* command in commandsArray) {
        [self.db executeUpdate: command];
    }
}

+ (ServiceFactoryImpl* ) getInstance{
    if(serviceFactoryInstance == nil){
        serviceFactoryInstance = [[ServiceFactoryImpl alloc] init];
    }
    return serviceFactoryInstance;
}

- (NSString *)getDatabasePath
{
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"newsdb.db"];
}

- (NewsFeedServiceImpl*) getNewsFeedService{
    if(newsFeedServiceImpl == nil){
        newsFeedServiceImpl = [[NewsFeedServiceImpl alloc] initWithDb: self.db];
    }
    return newsFeedServiceImpl;
}
- (NewsArticleServiceImpl*) getNewsArticleService{
    if(newsArticleServiceImpl == nil){
        newsArticleServiceImpl = [[NewsArticleServiceImpl alloc] initWithDb: self.db];
    }
    return newsArticleServiceImpl;
}

- (OwncloudSyncService* ) getOwncloudSyncService{
    return [[OwncloudSyncService alloc] initWithDb:self.db];
}

@end
