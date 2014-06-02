//
//  NewsAPI12.h
//  owncloudnews
//
//  Created by Lukas Köll on 28.01.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCNFolder.h"

typedef enum {
    FEED = 0,
    FOLDER = 1,
    STARRED = 2,
    ALL = 3
    } NEWS_API_QUERY_TYPE;

@interface OCNNewsAPI12 : NSObject {
    NSString* apiUrl;
    NSString* username;
    NSString* password;
}

/**
 * Initializer
 */

- (id) initWithProtocol: (NSString* ) protocol
              andDomain: (NSString* ) domain
            andUsername: (NSString* ) username
            andPassword: (NSString*) password;

- (void) updateSettingsFromUserDefaultsController;

/**
 * will throw exception on connection or api version error
 */
+ (BOOL) checkSettingsWithProtocol: (NSString* )protocol
                        andBaseUrl: (NSString* )baseUrl
                       andUsername: (NSString*) username
                       andPassword: (NSString*) password;

// All of the below items throw exceptions when something goes wrong!

/**
 * Folders
 */

- (NSArray*) getFolders;
- (NSArray*) createFolder: (NSString*) folderName;
- (void) deleteFolderWithId: (int) folderId;
- (void) renameFolderWithId: (int) folderId
                     toName: (NSString*) toName;
- (void) markItemsReadForFolderWithId: (int) folderId;

/**
 * Feeds
 */
- (NSArray*) getAllFeeds;
- (NSArray*) createFeedWithUrl: (NSString*)url;
- (NSArray*) createFeedWithUrl: (NSString*)url
               andParentFolder: (int) parentFolderId;
- (void) deleteFeedWithId: (int) feedId;
- (void) moveFeedWithId: (int) feedId
         toFolderWithId: (int) folderId;
- (void) markItemsReadForFeedWithId: (int) feedId;

/**
 * Items
 */

- (NSArray*) getItemsFromId: (int) feedId
              withBatchSize: (int) batchSize
                 withOffset: (int) offset
                   withType: (NEWS_API_QUERY_TYPE) type
             withUnreadOnly: (BOOL) unreadOnly;

-(NSArray*) getUpdatedItemsFromId: (int) feedId
                withLastModified: (int) lastModified
                        withType: (NEWS_API_QUERY_TYPE) type;

-(void) markItemReadWithId: (int) itemId;
-(void) markItemUnreadWithId: (int) itemId;
-(void) markItemsReadWithIds: (NSArray*) itemIds;
-(void) markItemsUnreadWithIds: (NSArray*) itemIds;
-(void) markItemStarredWithId: (int) itemId;
-(void) markItemsStarredWithIds: (NSArray*) itemIds;
-(void) markItemUnstarredWithId: (int) itemId;
-(void) markItemsUnstarredWithIds: (NSArray*) itemIds;
-(void) markAllItemsReadUntilId: (int) newestItemId;
@end

