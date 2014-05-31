//
//  OwncloudSyncService.h
//  owncloudnews
//
//  Created by Lukas Köll on 30.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "NewsAPI12.h"

@interface OwncloudSyncService : NSObject{
    FMDatabase* db;
    NewsAPI12* api;
}

- (id) initWithDb: (FMDatabase* )db;
- (void) syncDatabaseWithApi;

@end
