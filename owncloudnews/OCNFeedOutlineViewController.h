//
//  FeedOutlineViewController.h
//  owncloudnews
//
//  Created by Lukas Köll on 29.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "OcnViewController.h"
#import "OCNServiceFactoryImpl.h"
#import "OCNItemListTableViewController.h"
#import "DatabaseObserver.h"

@interface OCNFeedOutlineViewController : OcnViewController <OCNDatabaseObserver>{
    OCNNewsFeedServiceImpl* newsFeedService;
}

@property (strong) IBOutlet NSTreeController *treeController;
@property (strong) IBOutlet  NSOutlineView *feedsOutline;
@property (strong) IBOutlet  OCNItemListTableViewController *itemListTableViewController;

- (id) initWithItemListTableViewController: (OCNItemListTableViewController*) aItemListTableViewController;

- (void) loadArticlesForFeed: (OCNNewsFeed*) feed;

// comply to DatabaseObserver
- (void) databaseChanged;
@end
