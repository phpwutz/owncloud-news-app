//
//  NewsFeedServiceImpl.h
//  owncloudnews
//
//  Created by Lukas Köll on 30.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface NewsFeedServiceImpl : NSObject

@property (strong) FMDatabase* db;

- (id) initWithDb: (FMDatabase*)database;
- (NSArray*) getAllFeeds;

@end
