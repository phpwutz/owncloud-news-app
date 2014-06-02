//
//  NewsFeed.h
//  owncloudnews
//
//  Created by Lukas Köll on 26.01.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMResultSet.h"
#import "OCNOutlineNode.h"

@interface OCNNewsFeed : OCNOutlineNode{
    BOOL imageLoaded;
    NSImage* favImage;
}

@property int identity;
@property int unreadCount;
@property int folderId;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *faviconLink;
@property (strong, nonatomic) NSString *link;

@property (strong, nonatomic) NSMutableArray* items;

// These methods need to be updated when the model properties change!
-(id) initFromDictionary: (NSDictionary* ) dictionary;
-(id) initFromDbRow: (FMResultSet*) row;


-(NSArray*) children;
-(BOOL)isLeaf;
-(NSImage *)image;
@end
