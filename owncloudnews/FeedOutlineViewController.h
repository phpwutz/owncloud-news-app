//
//  FeedOutlineViewController.h
//  owncloudnews
//
//  Created by Lukas Köll on 29.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "OcnViewController.h"
#import "ServiceFactoryImpl.h"
#import "ItemListTableViewController.h"
#import "DatabaseObserver.h"

@interface FeedOutlineViewController : OcnViewController <NSOutlineViewDelegate, DatabaseObserver>{
    NewsFeedServiceImpl* newsFeedService;
}

@property (strong) IBOutlet NSTreeController *treeController;
@property (strong) IBOutlet  NSOutlineView *feedsOutline;
@property (strong) IBOutlet  ItemListTableViewController *itemListTableViewController;

- (id) initWithItemListTableViewController: (ItemListTableViewController*) aItemListTableViewController;

- (void)outlineView:(NSOutlineView *)outlineView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn item:(id)item;
- (void)outlineViewSelectionDidChange:(NSNotification *) aNotification;

// comply to DatabaseObserver
- (void) databaseChanged;
@end
