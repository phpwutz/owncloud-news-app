//
//  DatabaseService.m
//  owncloudnews
//
//  Created by Lukas Köll on 01.06.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "DatabaseService.h"

@implementation DatabaseService

- (id)init{
    self = [super init];
    
    NSString* dbPath = [self getDatabasePath];
    NSLog(@"opening sqlite db %@", dbPath);
    db = [FMDatabase databaseWithPath: dbPath];
    if (![db open]) {
        [self initializeDatabase];
    }
    
    FMResultSet* res = [db executeQuery:@"SELECT * from feeds" ];
    if(res == nil){ // initialize db schema if not done yet
        [self initializeDatabase];
    }
    return self;
}

- (FMResultSet *)executeQuery:(NSString*)sql, ...{
    va_list args;
    va_start(args, sql);
    FMResultSet* res = [db executeQuery:sql withVAList: args];
    va_end(args);
    return res;
}

- (BOOL)executeUpdate:(NSString*)sql, ...{
    va_list(args);
    va_start(args, sql);
    BOOL result = [db executeUpdate:sql withVAList:args];
    va_end(args);
    return result;
}

- (NSString *)getDatabasePath
{
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"newsdb.db"];
}

- (void) initializeDatabase{
    // when we recreate the database, we also reset the lastUpdateSync flag to 0
    NSUserDefaultsController* userDefaults = [NSUserDefaultsController sharedUserDefaultsController];
    [[userDefaults defaults] setValue: [NSNumber numberWithInteger: 0] forKey:@"lastUpdateSync"];
    
    NSError* err;
    NSString *dbSchemaPath = [[NSBundle mainBundle] pathForResource:@"dbschema" ofType:@"sqlite"];
    NSString *dbSchemaContents = [NSString stringWithContentsOfFile: dbSchemaPath encoding:NSUTF8StringEncoding error:&err];
    
    NSArray *commandsArray = [dbSchemaContents componentsSeparatedByString: @"\n"];
    
    for (NSString* command in commandsArray) {
        [db executeUpdate: command];
    }
}
@end
