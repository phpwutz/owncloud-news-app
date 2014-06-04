//
//  FeedOutlineViewController.m
//  owncloudnews
//
//  Created by Lukas Köll on 29.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "OCNFeedOutlineViewController.h"
#import "ImageAndTextCell.h"
#import "fmdb/FMDatabase.h"
#import "OCNNewsFeed.h"
#import "OCNFolder.h"
#import "OCNServiceFactoryImpl.h"

@implementation OCNFeedOutlineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        newsFeedService = [[OCNServiceFactoryImpl getInstance] getNewsFeedService];
        [[[OCNServiceFactoryImpl getInstance] getDatabaseService] addObserver:self];
    }
    return self;
}

- (id)init {
    return [[OCNFeedOutlineViewController alloc] initWithNibName:@"FeedOutlineView" bundle:nil];
}

- (id) initWithItemListTableViewController: (OCNItemListTableViewController*) aItemListTableViewController{
    self = [self init];
    if(self){
        _itemListTableViewController = aItemListTableViewController;
    }
    return self;
}

- (void) awakeFromNib{
    [_feedsOutline setDataSource: _treeController];
    [self databaseChanged];
}

- (void) databaseChanged{
    NSArray* data = [newsFeedService getAllFeeds];
    [self.treeController setContent:nil];
    for (int i = 0; i < [data count]; i++) {
        [self.treeController addObject: [data objectAtIndex: i]];
    }
}
- (void) loadArticlesForFeed: (OCNNewsFeed*) feed{
    [_itemListTableViewController loadArticlesForFeed:feed];
}
- (void)didLoadView {
    
}

@end
