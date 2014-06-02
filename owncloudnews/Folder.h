//
//  Folder.h
//  owncloudnews
//
//  Created by Lukas Köll on 28.01.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMResultSet.h"
#import "OutlineNode.h"

@interface Folder : OutlineNode <NSCoding, NSCopying>

@property (atomic) int identity;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSMutableArray* feeds;
@property (atomic, getter = unreadCount, readonly) NSInteger unreadCount;

-(id) init;
-(id) initFromDictionary: (NSDictionary* ) dictionary;
-(id) initFromDbRow: (FMResultSet*) row;
-(NSArray*) children;
-(NSImage *)image;
@end
