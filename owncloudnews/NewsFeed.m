//
//  NewsFeed.m
//  owncloudnews
//
//  Created by Lukas Köll on 26.01.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "NewsFeed.h"

@implementation NewsFeed

-(id) initFromDictionary: (NSDictionary* ) dictionary
{
    self = [super init];
    
    if(self){
        self.identity = [[dictionary valueForKey:@"id"] intValue];
        self.unreadCount =  [[dictionary valueForKey:@"unreadCount"] intValue];
        self.folderId =  [[dictionary valueForKey:@"folderId"] intValue];
        self.url = (NSString*) [dictionary valueForKey:@"url"];
        self.title = (NSString*) [dictionary valueForKey:@"title"];
        self.faviconLink = (NSString*) [dictionary valueForKey:@"faviconLink"];
        self.link = (NSString*) [dictionary valueForKey:@"link"];
    }
    return self;
}

-(id) initFromDbRow: (FMResultSet* ) row
{
    self = [super init];
    
    if(self){
        self.identity = [row intForColumn:@"id"];
        self.unreadCount =  [row intForColumn:@"unreadCount"];
        self.folderId =  [row intForColumn:@"folderId"];
        self.url = [row stringForColumn:@"url"];
        self.title = [row stringForColumn:@"title"];
        self.faviconLink = [row stringForColumn:@"faviconLink"];
        self.link = [row stringForColumn:@"link"];
    }
    return self;
}

-(NSArray *) children{
    return nil;
}

-(BOOL)isLeaf {
    return YES;
}
-(NSImage *)image {
    if(!imageLoaded){
        NSURL *imageURL = [NSURL URLWithString:_faviconLink];
        favImage = [[NSImage alloc] initWithContentsOfURL:imageURL];
        
        NSSize imageSize;
        
        imageSize.width = 15.0;  // in points (384 pts = 512 px )
        
        imageSize.height = 15.0;
        [favImage setCacheMode:NSImageCacheAlways];
        [favImage setSize:imageSize]; // set image size
        imageLoaded = YES;
    }
    return favImage;
}

@end
