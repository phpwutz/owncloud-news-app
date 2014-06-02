//
//  OwncloudSyncService.h
//  owncloudnews
//
//  Created by Lukas Köll on 30.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "OCNNewsAPI12.h"

@interface OCNOwncloudSyncService : NSObject{
    OCNNewsAPI12* api;
}

- (BOOL) syncDatabaseWithApi;

@end
