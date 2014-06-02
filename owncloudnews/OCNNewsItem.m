//
//  NewsItem.m
//  owncloudnews
//
//  Created by Lukas Köll on 26.01.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "OCNNewsItem.h"

@implementation OCNNewsItem

-(id) initFromDictionary: (NSDictionary* ) dictionary
{
    self = [super init];
    
    if(self){
        self.identity = [[dictionary valueForKey:@"id"] intValue];
        self.feedId = [[dictionary valueForKey:@"feedId"] intValue];
        self.guid =  (NSString*)[dictionary valueForKey:@"guid"];
        self.guidHash = (NSString*)[dictionary valueForKey:@"guidHash"];
        self.title = (NSString*) [dictionary valueForKey:@"title"];
        
        self.url = (NSString*) [dictionary valueForKey:@"url"];
        self.author = (NSString*) [dictionary valueForKey:@"author"];
        self.pubDate = [NSDate dateWithTimeIntervalSince1970: [[dictionary valueForKey:@"pubDate"] intValue]];
        self.body = (NSString*) [dictionary valueForKey:@"body"];
        self.enclosureMime = (NSString*) [dictionary valueForKey:@"enclosureMime"];
        self.unread = [[dictionary valueForKey:@"unread"] boolValue];
        self.starred = [[dictionary valueForKey:@"starred"] boolValue];
    }
    return self;
}

-(id) initFromDbRow: (FMResultSet* ) row
{
    self = [super init];
    
    if(self){
        
        self.identity = [row intForColumn:@"id"];
        self.feedId = [row intForColumn:@"feedId"];
        self.guid =  [row stringForColumn:@"guid"];
        self.guidHash = [row stringForColumn:@"guidHash"];
        self.title = [row stringForColumn:@"title"];
        
        self.url = [row stringForColumn:@"url"];
        self.author = [row stringForColumn:@"author"];
        self.pubDate = [NSDate dateWithTimeIntervalSince1970:[row intForColumn:@"pubDate"]];
        self.body = [row stringForColumn:@"body"];
        self.enclosureMime =[row stringForColumn:@"enclosureMime"];
        self.unread = [row boolForColumn:@"unread"];
        self.starred = [row boolForColumn:@"starred"];
    }
    return self;
}


@end
