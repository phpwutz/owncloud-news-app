//
//  Folder.m
//  owncloudnews
//
//  Created by Lukas Köll on 28.01.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "OCNFolder.h"
#import "OCNNewsFeed.h"

@implementation OCNFolder
-(id) init{
    self = [super init];
    _feeds = [[NSMutableArray alloc] init];
    return self;
}
-(NSInteger) unreadCount{
    NSInteger count = 0;
    for(OCNNewsFeed* feed in _feeds){
        count += feed.unreadCount;
    }
    return count;
}

-(id) initFromDictionary: (NSDictionary* ) dictionary{
    self = [super init];
    
    if(self){
        _feeds = [[NSMutableArray alloc] init];
        _identity = [[dictionary valueForKey:@"id"] intValue];
        _title =  (NSString*)[dictionary valueForKey:@"name"];
    }
    return self;
}

-(id) initFromDbRow: (FMResultSet* ) row
{
    self = [super init];
    
    if(self){
        _feeds = [[NSMutableArray alloc] init];
        _identity = [row intForColumn:@"id"];
        _title = [row stringForColumn:@"folderName"];
    }
    return self;
}

-(NSArray *) children{
    return _feeds;
}

-(NSImage *)image {
    NSImage* img = [NSImage imageNamed:NSImageNameFolder];
    NSSize imageSize;
    
    imageSize.width = 15.0;  // in points (384 pts = 512 px )
    
    imageSize.height = 15.0;
    
    [img setSize:imageSize]; // set image size
    return img;
}
@end
