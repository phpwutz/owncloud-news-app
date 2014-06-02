//
//  NewsItem.h
//  owncloudnews
//
//  Created by Lukas Köll on 26.01.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMResultSet.h"

@interface OCNNewsItem : NSObject

@property int identity;
@property int feedId;
@property (strong, nonatomic) NSString *guid;
@property (strong, nonatomic) NSString *guidHash;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property NSDate* pubDate;
@property (strong, nonatomic) NSString *body;
@property (strong, nonatomic) NSString *enclosureMime;
@property bool unread;
@property bool starred;

-(id) initFromDictionary: (NSDictionary* ) dictionary;
-(id) initFromDbRow: (FMResultSet*) row;

@end
