//
//  DatabaseService.h
//  owncloudnews
//
//  Created by Lukas Köll on 01.06.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "Observable.h"

@interface DatabaseService : Observable{
    FMDatabase* db;
}

- (FMResultSet *)executeQuery:(NSString*)sql, ...;
- (BOOL)executeUpdate:(NSString*)sql, ...;

@end
